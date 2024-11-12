# Ressource S3 Bucket de backup dans us-east-1
# resource "aws_s3_bucket" "backup_bucket" {
#   provider = aws.us_east_1  # Utilise le provider pour us-east-1
#   bucket   = "s3spring-backup"  # Nom du bucket de backup
#   acl      = "private"

#   versioning {
#     enabled = true  # Activez le versioning si nécessaire
#   }

#   tags = {
#     Name        = "springbackupbucket"
#     Environment = "Dev"
#   }
# }

# (Optionnel) Configuration de la réplication pour synchroniser les données
# resource "aws_s3_bucket_replication_configuration" "replication" {
#   provider = aws.us_east_1  # Utilise le provider pour le bucket principal

#   bucket = aws_s3_bucket.s3spring.id  # Bucket principal

#   role = aws_iam_role.replication_role.arn  # Rôle pour la réplication

#   rules {
#     id     = "replicate-everything"
#     status = "Enabled"

#     destination {
#       bucket        = aws_s3_bucket.backup_bucket.arn  # Bucket de backup
#       storage_class = "STANDARD"
#     }
#   }
# }

# resource "aws_iam_role" "replication_role" {
#   name = "s3_replication_role"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [{
#       Action    = "sts:AssumeRole"
#       Principal = {
#         Service = "s3.amazonaws.com"
#       }
#       Effect    = "Allow"
#       Sid       = ""
#     }]
#   })
# }

# resource "aws_iam_role_policy" "replication_policy" {
#   name   = "replication_policy"
#   role   = aws_iam_role.replication_role.id
#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [{
#       Effect = "Allow"
#       Action = [
#         "s3:ReplicateObject",
#         "s3:ReplicateDelete",
#         "s3:ReplicateTags"
#       ]
#       Resource = "*"
#     }]
#   })
# }
