terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 4.0"
        }
    }
}

provider "aws" {
  region = "us-east-1a"
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
