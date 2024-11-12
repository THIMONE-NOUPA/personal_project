resource "aws_dynamodb_table" "terraform_locks" {
  name         = "springdynamodb"
  billing_mode = "PAY_PER_REQUEST"

  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  ttl {
    enabled = false
  }

  tags = {
    Name = "dynamospring"
  }
}
