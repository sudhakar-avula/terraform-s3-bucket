provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "my-s3-bucket" {
    bucket = "s3-asr-terraform-first-project-023611"

    tags = {
        Name = "My bucket"
    }
}

resource "aws_s3_bucket_acl" "my-s3-bucket-acl" {
  bucket = aws_s3_bucket.my-s3-bucket.id

  acl = "private"
}
