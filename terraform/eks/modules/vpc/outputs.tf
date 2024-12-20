output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.this.id
}

output "env" {
  description = "Infrastructure environment"
  value       = var.env
}

output "vpc_cidr" {
  description = "VPC cidr block"
  value       = aws_vpc.this.cidr_block
}