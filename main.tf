provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "my-s3-bucket" {
    bucket = "s3-asr-terraform-first-project"
    acl = "private"

    tags = {
        Name = "My bucket"
    }
}
