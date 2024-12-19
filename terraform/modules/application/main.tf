resource "kubernetes_namespace_v1" "argocd" {
  metadata {
    name = "argocd"
  }
}

resource "helm_release" "argocd" {
  name = "argocd"

  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  create_namespace = false
  version          = "7.3.11"

  values = [file("./modules/application/values/argocd.yml")]

  depends_on = [ kubernetes_namespace_v1.argocd ]
}

resource "kubernetes_namespace_v1" "provedcode" {
  metadata {
    name = "provedcode"
  }

  depends_on = [ helm_release.argocd ]
}

resource "kubernetes_secret_v1" "pg_secrets" {
  metadata {
    name      = "pg-secrets"
    namespace = "provedcode"
  }

  type = "Opaque"

  data = {
    APP_MODE      = var.env
    BUCKET        = var.s3_bucket_id
    S3_ACCESS_KEY = var.iam_access_key_id
    S3_SECRET_KEY = var.iam_access_key_secret
    S3_REGION     = var.s3_bucket_region
    APP_USER      = var.db_instance_username
    APP_PASSWORD  = var.db_instance_password
    APP_DB        = var.db_instance_db_name
    DB_URL        = "${var.db_instance_endpoint}/${var.db_instance_db_name}"
  }

  depends_on = [kubernetes_namespace_v1.provedcode]
}

resource "kubernetes_manifest" "application_argocd_provedcode" {
  manifest = {
    "apiVersion" = "argoproj.io/v1alpha1"
    "kind"       = "Application"
    "metadata" = {
      "finalizers" = [
        "resources-finalizer.argocd.argoproj.io",
      ]
      "name"      = "provedcode"
      "namespace" = "argocd"
    }
    "spec" = {
      "destination" = {
        "server" = "https://kubernetes.default.svc"
      }
      "project" = "default"
      "source" = {
        "directory" = {
          "recurse" = true
        }
        "path"           = "kubernetes/eks"
        "repoURL"        = "https://github.com/yyev89/provedcode-project-infrastructure.git"
        "targetRevision" = "HEAD"
      }
      "syncPolicy" = {
        "automated" = {
          "allowEmpty" = false
          "prune"      = true
          "selfHeal"   = true
        }
        "syncOptions" = [
          "Validate=true",
          "CreateNamespace=false",
          "PruneProgapationPolicy=foreground",
          "PruneLast=true",
        ]
      }
    }
  }

  depends_on = [kubernetes_secret_v1.pg_secrets]
}