variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "env" {
  description = "Infrastructure environment"
  type        = string
}

variable "nat_id" {
  description = "ID of the NAT gateway"
  type        = string
}

variable "igw_id" {
  description = "ID of the Internet gateway"
  type        = string
}

variable "subnet_public1_id" {
  description = "ID of the first public zone"
  type        = string
}

variable "subnet_public2_id" {
  description = "ID of the second public zone"
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