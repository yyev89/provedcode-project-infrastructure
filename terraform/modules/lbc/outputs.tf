output "release_lbc_id" {
  description = "ID of the AWS load balancer controller"
  value       = helm_release.aws_lbc.id
}