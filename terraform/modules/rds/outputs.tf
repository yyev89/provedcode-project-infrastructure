output "db_instance_username" {
  description = "RDS username"
  value       = aws_db_instance.this.username
}

output "db_instance_password" {
  description = "RDS password"
  value       = aws_db_instance.this.password
  sensitive   = true
}

output "db_instance_db_name" {
  description = "RDS database name"
  value       = aws_db_instance.this.db_name
}

output "db_instance_endpoint" {
  description = "RDS instance endpoint"
  value       = aws_db_instance.this.endpoint
}