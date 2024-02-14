provider "aws" {
  region = "ap-south-1"
}
#creating user
resource "aws_s3_bucket" "practice_bucket" {
  bucket = "prathamesh"
}

resource "aws_iam_user" "new_user" {
  name = "akshata"
}