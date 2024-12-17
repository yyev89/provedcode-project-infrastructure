output "eks_node_group_status" {
  description = "EKS managed node group status"
  value       = aws_eks_node_group.general.status
}