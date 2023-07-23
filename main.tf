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

# Resource to avoid error "AccessControlListNotSupported: The bucket does not allow ACLs"
resource "aws_s3_bucket_ownership_controls" "s3_bucket_acl_ownership" {
  bucket = aws_s3_bucket.my-s3-bucket.id
  rule {
    object_ownership = "ObjectWriter"
  }
}
