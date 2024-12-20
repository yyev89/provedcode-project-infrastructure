resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name

  tags = {
    Name = "${var.env}-bucket"
  }
}

resource "aws_iam_user" "this" {
  name = var.bucket_user
}

resource "aws_iam_policy" "bucket_access" {
  name        = "bucket-access"
  description = "Policy granting access to a specific S3 bucket"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:ListBucket"
        ]
        Resource = aws_s3_bucket.this.arn
      },
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject"
        ]
        Resource = "${aws_s3_bucket.this.arn}/*"
      }
    ]
  })
}

resource "aws_iam_user_policy_attachment" "s3" {
  user       = aws_iam_user.this.name
  policy_arn = aws_iam_policy.bucket_access.arn
}

resource "aws_iam_access_key" "this" {
  user = aws_iam_user.this.name
}