provider "helm" {
  kubernetes {
    config_path    = "~/.kube/config"
    config_context = "docker-desktop"
  }
}

provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "docker-desktop"
}

module "traefik" {
  source = "./modules/traefik"
}

module "argocd" {
  source      = "./modules/argocd"
  slack_token = var.slack_token
}

module "app" {
  source = "./modules/app"

  depends_on = [module.traefik, module.argocd]
}