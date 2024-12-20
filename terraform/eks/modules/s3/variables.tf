variable "env" {
  description = "Infrastructure environment"
  type        = string
}

variable "bucket_name" {
  description = "Amazon S3 bucket name for user photos"
  type        = string
  default     = "prod-provedcode-app-bucket"
}

variable "bucket_user" {
  description = "Username for S3 bucket access"
  type        = string
  default     = "app_user"
}