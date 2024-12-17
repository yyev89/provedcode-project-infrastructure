provider "aws" {
  region = var.region
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
}

module "gateways" {
  source            = "./modules/gateways"
  vpc_id            = module.vpc.vpc_id
  env               = module.vpc.env
  subnet_public1_id = module.subnets.subnet_public1_id
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
}

module "eks" {
  source             = "./modules/eks"
  env                = module.vpc.env
  eks_name           = module.subnets.eks_name
  subnet_private1_id = module.subnets.subnet_private1_id
  subnet_private2_id = module.subnets.subnet_private2_id
}

module "nodegroup" {
  source             = "./modules/nodegroup"
  env                = module.vpc.env
  eks_name           = module.subnets.eks_name
  eks_version        = module.eks.eks_version
  subnet_private1_id = module.subnets.subnet_private1_id
  subnet_private2_id = module.subnets.subnet_private2_id
}

module "lbc" {
  source                = "./modules/lbc"
  region                = var.region
  env                   = module.vpc.env
  vpc_id                = module.vpc.vpc_id
  eks_name              = module.eks.eks_name
  eks_node_group_status = module.nodegroup.eks_node_group_status
}

module "rds" {
  source             = "./modules/rds"
  env                = module.vpc.env
  vpc_id             = module.vpc.vpc_id
  vpc_cidr           = module.vpc.vpc_cidr
  subnet_private1_id = module.subnets.subnet_private1_id
  subnet_private2_id = module.subnets.subnet_private2_id
  db_password        = var.db_password
}

module "s3" {
  source = "./modules/s3"
  env    = module.vpc.env
}