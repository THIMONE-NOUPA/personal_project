# Disable versioning for the S3 bucket
resource "aws_s3_bucket_versioning" "thims3_versioning" {
  bucket = aws_s3_bucket.thims3.id # Reference to the S3 bucket

  # Set the status of versioning to suspended
  versioning_configuration {
    status = "Suspended" # Use "Suspended" to disable versioning
  }
}
