provider "aws" {
  region = "ap-south-1"
}
#creating user
resource "aws_s3_bucket" "practice_bucket" {
  bucket = "lallya"
}

resource "aws_iam_user" "new_user" {
  name = "akshata"
}

resource "aws_iam_policy" "iam_s3_policy" {
  name        = "specific-bucket-access-Policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:GetObject",
          "s3:ListBucket"
        ]
        Effect   = "Allow"
        Resource = aws_s3_bucket.practice_bucket.arn 
      },
    ]
  })
}
