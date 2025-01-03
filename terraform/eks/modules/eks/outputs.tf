output "eks_name" {
  description = "Name of the EKS cluster"
  value       = aws_eks_cluster.this.name
}

output "eks_version" {
  description = "EKS cluster kubernetes version"
  value       = var.eks_version
}

output "eks_cluster_endpoint" {
  description = "EKS cluster endpoint"
  value       = data.aws_eks_cluster.this.endpoint
}

output "eks_cluster_ca_certificate" {
  description = "EKS cluster CA certificate"
  value       = data.aws_eks_cluster.this.certificate_authority[0].data
}

output "eks_cluster_auth_token" {
  description = "EKS cluster auth token"
  value       = data.aws_eks_cluster_auth.this.token
}