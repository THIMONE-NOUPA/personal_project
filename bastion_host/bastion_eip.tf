resource "aws_eip" "bastion_eip" {
  depends_on = [
    aws_instance.bastion_host
  ]
  instance = aws_instance.bastion_host.id
  domain   = "vpc"  # Set to "vpc" if the EC2 instance is in a VPC
  
  tags = {
    Name        = "bastion_eip"
    Environment = "Development"
    Project     = "bastion_host"
    Company     = "DEL"
  }
}
