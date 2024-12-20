output "nat_id" {
  description = "ID of the NAT gateway"
  value       = aws_nat_gateway.this.id
}

output "igw_id" {
  description = "ID of the Internet gateway"
  value       = aws_internet_gateway.this.id
}