variable "db_instance_username" {
  description = "RDS username"
  type        = string
  default     = "app_user"
}

variable "db_instance_password" {
  description = "RDS password"
  type        = string
  default     = "app_pass"
}

variable "db_instance_db_name" {
  description = "RDS database name"
  type        = string
  default     = "provedcode"
}

variable "db_instance_endpoint" {
  description = "RDS instance endpoint"
  type        = string
  default     = "postgres:5432"
}

variable "env" {
  description = "Infrastructure environment"
  type        = string
  default     = "prod"
}

variable "s3_bucket_id" {
  description = "Amazon S3 bucket name for user photos"
  type        = string
  default     = "provedcode-app-bucket"
}

variable "s3_bucket_region" {
  description = "S3 region"
  type        = string
  default     = "eu-central-1"
}

variable "iam_access_key_id" {
  description = "S3 access key"
  type        = string
  default     = "access_key"
}

variable "iam_access_key_secret" {
  description = "S3 secret key"
  type        = string
  default     = "secret_key"
}