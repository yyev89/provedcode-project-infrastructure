variable "env" {
  description = "Infrastructure environment"
  type        = string
}

variable "eks_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "eks_version" {
  description = "EKS cluster kubernetes version"
  type        = string
  default     = "1.30"
}

variable "subnet_private1_id" {
  description = "ID of the first private zone"
  type        = string
}

variable "subnet_private2_id" {
  description = "ID of the second private zone"
  type        = string
}