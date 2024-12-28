variable "slack_token" {
  description = "Slack token for ArgoCD notifications into the channel"
  type        = string
}

variable "datadog_api_key" {
  description = "Datadog API Key"
  type        = string
}

variable "datadog_app_key" {
  description = "Datadog Application Key"
  type        = string
}