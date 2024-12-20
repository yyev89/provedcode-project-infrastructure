variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "env" {
  description = "Infrastructure environment"
  type        = string
}

variable "zone1" {
  description = "First availability zone"
  type        = string
  default     = "eu-central-1a"
}

variable "zone2" {
  description = "Second availability zone"
  type        = string
  default     = "eu-central-1b"
}

variable "eks_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "demo"
}