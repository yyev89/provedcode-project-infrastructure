variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "env" {
  description = "Infrastructure environment"
  type        = string
}

variable "subnet_public1_id" {
  description = "ID of the first public zone"
  type        = string
}