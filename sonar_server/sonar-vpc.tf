

resource "aws_security_group" "sonarqube_sg" {
  name        = "sonarqube_sg"
  description = "Security group for SonarQube access"
  vpc_id      = var.spring_vpc  # Utiliser l'ID du VPC passé

  # Allow SSH access
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Autoriser l'accès SSH depuis n'importe où
  }

  # Allow SonarQube access on port 9000 from anywhere
  ingress {
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Autoriser l'accès à SonarQube depuis n'importe où
  }

  # Allow SonarQube access on port 9000 from ALB security group
  ingress {
    from_port       = 9000
    to_port         = 9000
    protocol        = "tcp"
    security_groups = [var.alb_security_group_id]  # Autoriser le trafic depuis l'ALB
  }

  # Allow sonarqube access on port 9000 from bastion_host security group
  ingress {
    from_port       = 9000
    to_port         = 9000
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
    Name = "sonarqube_sg"
  }
}

