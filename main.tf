provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "my-s3-bucket" {
    bucket = "s3-asr-terraform-first-project-0236"
    acl = "private"

    tags = {
        Name = "My bucket"
    }
}
