output "route_table_private_id" {
  description = "ID of the private route table"
  value       = aws_route_table.private.id
}

output "route_table_public_id" {
  description = "ID of the public route table"
  value       = aws_route_table.public.id
}