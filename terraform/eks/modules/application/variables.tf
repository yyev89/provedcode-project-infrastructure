variable "env" {
  description = "Infrastructure environment"
  type        = string
}

variable "s3_bucket_id" {
  description = "Amazon S3 bucket name for user photos"
  type        = string
}

variable "iam_access_key_id" {
  description = "S3 access key"
  type        = string
}

variable "iam_access_key_secret" {
  description = "S3 secret key"
  type        = string
}

variable "s3_bucket_region" {
  description = "S3 region"
  type        = string
}

variable "db_instance_username" {
  description = "RDS username"
  type        = string
}

variable "db_instance_password" {
  description = "RDS password"
  type        = string
}

variable "db_instance_db_name" {
  description = "RDS database name"
  type        = string
}

variable "db_instance_endpoint" {
  description = "RDS instance endpoint"
  type        = string
}