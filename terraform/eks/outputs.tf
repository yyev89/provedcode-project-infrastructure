output "db_instance_username" {
  description = "RDS username"
  value       = module.rds.db_instance_username
}

output "db_instance_password" {
  description = "RDS password"
  value       = module.rds.db_instance_password
  sensitive   = true
}

output "db_instance_db_name" {
  description = "RDS database name"
  value       = module.rds.db_instance_db_name
}

output "db_instance_endpoint" {
  description = "RDS instance endpoint"
  value       = "${module.rds.db_instance_endpoint}/${module.rds.db_instance_db_name}"
}

output "env" {
  description = "Infrastructure environment"
  value       = module.vpc.env
}

output "s3_bucket_id" {
  description = "Amazon S3 bucket name for user photos"
  value       = module.s3.s3_bucket_id
}

output "s3_bucket_region" {
  description = "S3 region"
  value       = module.s3.s3_bucket_region
}

output "iam_access_key_id" {
  description = "S3 access key"
  value       = module.s3.iam_access_key_id
}

output "iam_access_key_secret" {
  description = "S3 secret key"
  value       = module.s3.iam_access_key_secret
  sensitive   = true
}