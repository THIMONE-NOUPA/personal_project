variable "spring_vpc" {
  description = "ID of the VPC for bastion_host"
  type        = string
}

# Security Group allowing SSH access
resource "aws_security_group" "bastion_ssh" {
  
  name        = "bastion_ssh"
  description = "Security group for bastion access"
  vpc_id      = var.spring_vpc  # Utiliser l'ID du VPC passé

  # Allow SSH access
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Autoriser l'accès SSH depuis n'importe où
  }

  # Allow all outbound traffic (egress)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # Autoriser tout le trafic sortant
  }

  tags = {
    Name = "bastion_ssh"
  }
}
