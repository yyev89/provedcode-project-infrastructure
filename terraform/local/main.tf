provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

module "traefik" {
  source = "./modules/traefik"
}

module "argocd" {
  source      = "./modules/argocd"
  slack_token = var.slack_token
}

module "datadog" {
  source          = "./modules/datadog"
  datadog_api_key = var.datadog_api_key
  datadog_app_key = var.datadog_app_key
}

module "app" {
  source = "./modules/app"

  depends_on = [module.traefik, module.argocd, module.datadog]
}