variable "datadog_api_key" {
  description = "Datadog API Key"
  type        = string
}

variable "datadog_app_key" {
  description = "Datadog Application Key"
  type        = string
}

variable "cluster_name" {
  description = "Name of the kubernetes cluster"
  type        = string
  default     = "docker-desktop"
}
