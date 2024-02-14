provider "aws" {
  region = "ap-south-1"
}
#creating bucket
resource "aws_s3_bucket" "practice_bucket" {
  bucket = "lallya"
}
#creating user
resource "aws_iam_user" "new_user" {
  name = "akshata"
}
#creating policy
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
#attached policy to user
resource "aws_iam_user_policy_attachment" "attach_policy" {
  user = aws_iam_user.new_user.name
  policy_arn = aws_iam_policy.iam_s3_policy.arn
}