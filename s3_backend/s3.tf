provider "aws" {
  region = "us-east-1" # Your chosen region
}

resource "aws_s3_bucket" "thims3" {
  bucket = "thims3" # Ensure this name is unique globally

  tags = {
    Name        = "thims3"
    Environment = "Dev"
  }
}

