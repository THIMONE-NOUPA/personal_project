

# Security Group allowing SSH, Jenkins (8080) access
resource "aws_security_group" "jenkins_ssh" {
  
  name        = "jenkins_ssh"
  description = "Security group for Jenkins access"
  vpc_id      = var.spring_vpc  # Utiliser l'ID du VPC passé

  # Allow SSH access
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Autoriser l'accès SSH depuis n'importe où
  }

  # Allow Jenkins access on port 8080 from anywhere
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Autoriser l'accès à Jenkins depuis n'importe où
  }

  # Allow Jenkins access on port 8080 from ALB security group
  ingress {
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = [var.alb_security_group_id]  # Autoriser le trafic depuis l'ALB
  }

    # Allow jenkins access on port 8080 from bastion_host security group
  ingress {
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = [var.bastion_ssh]  # Autoriser le trafic depuis le bastion_host
  }

  # Allow all outbound traffic (egress)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # Autoriser tout le trafic sortant
  }

  tags = {
    Name = "jenkins_ssh"
  }
}
