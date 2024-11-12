resource "aws_instance" "jenkins_server" {
  depends_on = [
    aws_security_group.jenkins_ssh
  ]

  ami = var.ubuntu_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.jenkins_ssh.id]
  subnet_id              = var.spring_private_subnet  # Référence le subnet privé
  associate_public_ip_address = false  # Désactive l'IP publique


# user_data = <<-EOF
#               #!/bin/bash
#               
#               # Update and install dependencies
#               apt-get update -y
#               apt-get install -y openjdk-11-jdk wget gnupg2 curl unzip apt-transport-https software-properties-common ca-certificates
#
#               # Add Jenkins key (new method)
#               curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | tee \
#               /usr/share/keyrings/jenkins-keyring.asc > /dev/null
#
#               # Add Jenkins repository using the keyring
#               echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
#               https://pkg.jenkins.io/debian-stable binary/ | tee \
#               /etc/apt/sources.list.d/jenkins.list > /dev/null
#
#               # Update and install Jenkins
#               apt-get update -y
#               apt-get install -y jenkins
#               
#               # Start Jenkins and enable it to run on boot
#               systemctl start jenkins
#               systemctl enable jenkins
#
#               # Allow SSH and Jenkins ports in the firewall
#               ufw allow 22/tcp
#               ufw allow 8080/tcp
#               ufw --force enable
# EOF


  tags = {
    Name        = var.instance_name
    Create_By   = "Terraform"
    Environment = var.environment
    Project     = "jenkins_server"
    Company     = "DEL"
  }
}
