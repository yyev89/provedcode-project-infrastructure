variable "region" {
  description = "Region to deploy infrastructure"
  type        = string
  default     = "eu-central-1"
}

variable "db_password" {
  description = "RDS root password"
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