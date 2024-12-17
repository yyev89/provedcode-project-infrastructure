output "s3_bucket_id" {
  description = "Amazon S3 bucket name for user photos"
  value       = aws_s3_bucket.this.id
}

output "iam_access_key_id" {
  description = "S3 access key"
  value       = aws_iam_access_key.this.id
}

output "iam_access_key_secret" {
  description = "S3 secret key"
  value       = aws_iam_access_key.this.secret
  sensitive   = true
}

output "s3_bucket_region" {
  description = "S3 region"
  value       = aws_s3_bucket.this.region
}