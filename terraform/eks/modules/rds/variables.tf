variable "env" {
  description = "Infrastructure environment"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC cidr block"
  type        = string
}

variable "subnet_private1_id" {
  description = "ID of the first private zone"
  type        = string
}

variable "subnet_private2_id" {
  description = "ID of the second private zone"
  type        = string
}

variable "db_user" {
  description = "RDS root user"
  type        = string
  default     = "app_user"
}

variable "db_password" {
  description = "RDS root password"
  type        = string
}

variable "db_name" {
  description = "RDS database name"
  type        = string
  default     = "provedcode"
}

variable "identifier_prefix" {
  description = "RDS identifier prefix for database"
  type        = string
  default     = "postgres-"
}

variable "allocated_storage" {
  description = "The size of allocated storage for database"
  type        = number
  default     = 8
}

variable "engine" {
  description = "Engine for the database"
  type        = string
  default     = "postgres"
}

variable "engine_version" {
  description = "Engine version for the database"
  type        = string
  default     = "16.3"
}

variable "instance_class" {
  description = "Instance class for the database compute"
  type        = string
  default     = "db.t3.micro"
}