output "eks_name" {
  description = "Name of the EKS cluster"
  value       = var.eks_name
}

output "subnet_public1_id" {
  description = "ID of the first public zone"
  value       = aws_subnet.public_zone1.id
}

output "subnet_public2_id" {
  description = "ID of the second public zone"
  value       = aws_subnet.public_zone2.id
}

output "subnet_private1_id" {
  description = "ID of the first private zone"
  value       = aws_subnet.private_zone1.id
}

output "subnet_private2_id" {
  description = "ID of the second private zone"
  value       = aws_subnet.private_zone2.id
}