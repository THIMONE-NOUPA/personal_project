# Create an Elastic IP
# resource "aws_eip" "jenkins_eip" {
#   depends_on = [
#     aws_instance.jenkins_server
#   ]
#   instance = aws_instance.jenkins_server.id
#   domain   = "vpc"   # Set to true if the EC2 instance is in a VPC

#   tags = {
#     Name        = "jenkins_eip"
#     Environment = "Development"
#     Project     = "jenkins"
#     Company     = "DEL"
#   }
# }

