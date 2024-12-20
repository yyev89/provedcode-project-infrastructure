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
}

variable "subnet_private1_id" {
  description = "ID of the first private zone"
  type        = string
}

variable "subnet_private2_id" {
  description = "ID of the second private zone"
  type        = string
}

variable "capacity_type" {
  description = "EC2 capacity type of nodes (ON_DEMAND, SPOT etc.)"
  type        = string
  default     = "ON_DEMAND"
}

variable "instance_types" {
  description = "EC2 type of node group instances"
  type        = list(string)
  default     = ["t3.medium"]
}

variable "desired_size" {
  description = "Desired size of EC2 nodes autoscaling group"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Maximum size of EC2 nodes autoscaling group"
  type        = number
  default     = 1
}

variable "min_size" {
  description = "Minimum size of EC2 nodes autoscaling group"
  type        = number
  default     = 1
}

variable "max_unavailable" {
  description = "Maximum size of unavailable EC2 nodes at once"
  type        = number
  default     = 1
}