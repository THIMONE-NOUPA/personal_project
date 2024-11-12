# Create an Elastic IP
# resource "aws_eip" "sonar_eip" {
#   depends_on = [
#     aws_instance.sonar_server
#   ]
#   instance = aws_instance.sonar_server.id
#   domain   = "vpc"  # Set to true if the EC2 instance is in a VPC
  
#   tags = {
#     Name        = "sonar_eip"
#     Environment = "Development"
#     Project     = "sonarqube"
#     Company     = "DEL"
#   }
# }


