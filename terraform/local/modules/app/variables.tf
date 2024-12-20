variable "db_instance_username" {
  description = "RDS username"
  default     = "app_user"
}

variable "db_instance_password" {
  description = "RDS password"
  default     = "app_pass"
}

variable "db_instance_db_name" {
  description = "RDS database name"
  default     = "provedcode"
}

variable "db_instance_endpoint" {
  description = "RDS instance endpoint"
  default     = "postgres:5432"
}

variable "env" {
  description = "Infrastructure environment"
  default     = "prod"
}

variable "s3_bucket_id" {
  description = "Amazon S3 bucket name for user photos"
  default     = "provedcode-app-bucket"
}

variable "s3_bucket_region" {
  description = "S3 region"
  default     = "eu-central-1"
}

variable "iam_access_key_id" {
  description = "S3 access key"
  default     = "access_key"
}

variable "iam_access_key_secret" {
  description = "S3 secret key"
  default     = "secret_key"
}