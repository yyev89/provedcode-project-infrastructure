variable "region" {
  description = "Region to deploy infrastructure"
  type        = string
  default     = "eu-central-1"
}

variable "db_password" {
  description = "RDS root password"
  type        = string
}