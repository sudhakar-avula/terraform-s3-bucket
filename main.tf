provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "my-s3-bucket" {
  bucket = "s3-asr-terraform-first-project-023611"
}

resource "aws_s3_bucket_ownership_controls" "s3_bucket_acl_ownership" {
  bucket = aws_s3_bucket.my-s3-bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "my-s3-bucket-acl" {
  depends_on = [aws_s3_bucket_ownership_controls.s3_bucket_acl_ownership]

  bucket = aws_s3_bucket.my-s3-bucket.id
  acl    = "private"
}
