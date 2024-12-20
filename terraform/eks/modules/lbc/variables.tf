variable "region" {
  description = "Region to deploy infrastructure"
  type        = string
}

variable "env" {
  description = "Infrastructure environment"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "eks_name" {
  description = "Name of the EKS cluster"
  type        = string
}