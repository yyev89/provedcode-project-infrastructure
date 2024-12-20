provider "aws" {
  region = var.region
}

provider "kubernetes" {
  config_path            = "~/.kube/config"
  host                   = module.eks.eks_cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.eks_cluster_ca_certificate)
  token                  = module.eks.eks_cluster_auth_token
}

provider "helm" {
  kubernetes {
    host                   = module.eks.eks_cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.eks_cluster_ca_certificate)
    token                  = module.eks.eks_cluster_auth_token
  }
}

module "vpc" {
  source = "./modules/vpc"
}

module "subnets" {
  source = "./modules/subnets"
  vpc_id = module.vpc.vpc_id
  env    = module.vpc.env

  depends_on = [module.vpc]
}

module "gateways" {
  source            = "./modules/gateways"
  vpc_id            = module.vpc.vpc_id
  env               = module.vpc.env
  subnet_public1_id = module.subnets.subnet_public1_id

  depends_on = [module.subnets]
}

module "routes" {
  source             = "./modules/routes"
  vpc_id             = module.vpc.vpc_id
  env                = module.vpc.env
  nat_id             = module.gateways.nat_id
  igw_id             = module.gateways.igw_id
  subnet_public1_id  = module.subnets.subnet_public1_id
  subnet_public2_id  = module.subnets.subnet_public2_id
  subnet_private1_id = module.subnets.subnet_private1_id
  subnet_private2_id = module.subnets.subnet_private2_id

  depends_on = [module.gateways]
}

module "eks" {
  source             = "./modules/eks"
  env                = module.vpc.env
  eks_name           = module.subnets.eks_name
  subnet_private1_id = module.subnets.subnet_private1_id
  subnet_private2_id = module.subnets.subnet_private2_id

  depends_on = [module.routes]
}

module "nodegroup" {
  source             = "./modules/nodegroup"
  env                = module.vpc.env
  eks_name           = module.eks.eks_name
  eks_version        = module.eks.eks_version
  subnet_private1_id = module.subnets.subnet_private1_id
  subnet_private2_id = module.subnets.subnet_private2_id

  depends_on = [module.eks]
}

module "lbc" {
  source   = "./modules/lbc"
  region   = var.region
  env      = module.vpc.env
  vpc_id   = module.vpc.vpc_id
  eks_name = module.eks.eks_name

  depends_on = [module.nodegroup]
}

module "rds" {
  source             = "./modules/rds"
  env                = module.vpc.env
  vpc_id             = module.vpc.vpc_id
  vpc_cidr           = module.vpc.vpc_cidr
  subnet_private1_id = module.subnets.subnet_private1_id
  subnet_private2_id = module.subnets.subnet_private2_id
  db_password        = var.db_password

  depends_on = [module.subnets]
}

module "s3" {
  source = "./modules/s3"
  env    = module.vpc.env

  depends_on = [module.vpc]
}

module "application" {
  source                = "./modules/application"
  env                   = module.vpc.env
  s3_bucket_id          = module.s3.s3_bucket_id
  iam_access_key_id     = module.s3.iam_access_key_id
  iam_access_key_secret = module.s3.iam_access_key_secret
  s3_bucket_region      = module.s3.s3_bucket_region
  db_instance_username  = module.rds.db_instance_username
  db_instance_password  = module.rds.db_instance_password
  db_instance_db_name   = module.rds.db_instance_db_name
  db_instance_endpoint  = module.rds.db_instance_endpoint

  depends_on = [module.s3, module.rds, module.lbc]
}