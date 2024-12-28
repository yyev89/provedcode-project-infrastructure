resource "kubernetes_namespace_v1" "datadog" {
  metadata {
    name = "datadog"
  }
}

resource "kubernetes_secret_v1" "datadog-secret" {
  metadata {
    name      = "datadog-secret"
    namespace = "datadog"
  }

  type = "Opaque"

  data = {
    api-key = var.datadog_api_key
    app-key = var.datadog_app_key
  }

  depends_on = [kubernetes_namespace_v1.datadog]
}

resource "helm_release" "datadog_agent" {
  name = "datadog-agent"

  repository       = "https://helm.datadoghq.com"
  chart            = "datadog"
  namespace        = "datadog"
  create_namespace = false
  version          = "3.84.3"

  values = [file("./modules/monitoring/values/datadog.yml")]

  set {
    name  = "datadog.clusterName"
    value = var.eks_name
  }

  depends_on = [kubernetes_secret_v1.datadog-secret]
}
