variable "cidr" {
  description = "VPC cidr block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "env" {
  description = "Infrastructure environment"
  type        = string
  default     = "prod"
}