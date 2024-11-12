
resource "aws_instance" "sonar_server" {
  depends_on = [
    aws_security_group.sonarqube_sg
  ]

  ami                    = var.ubuntu_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.sonarqube_sg.id]
  subnet_id              = var.spring_private_subnet  # Référence le subnet privé
  associate_public_ip_address = false  # Désactive l'IP publique
# user_data = <<-EOF
#     #!/bin/bash
#     # Update the package list
#     sudo apt-get update -y
#
#     # Install Java (required for SonarQube)
#     sudo apt-get install -y openjdk-17-jdk
#
#     # Download and install SonarQube
#     cd /opt
#     sudo wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-9.9.1.69595.zip
#     sudo apt-get install -y unzip
#     sudo unzip sonarqube-9.9.1.69595.zip
#     sudo mv sonarqube-9.9.1.69595 sonarqube
#     sudo useradd sonar
#     sudo chown -R sonar:sonar /opt/sonarqube
#     sudo chmod -R 755 /opt/sonarqube
#
#     # Set SonarQube to run on startup
#     sudo bash -c 'cat <<EOT >> /etc/systemd/system/sonar.service
#     [Unit]
#     Description=SonarQube service
#     After=syslog.target network.target
#
#     [Service]
#     Type=forking
#
#     ExecStart=/opt/sonarqube/bin/linux-x86-64/sonar.sh start
#     ExecStop=/opt/sonarqube/bin/linux-x86-64/sonar.sh stop
#
#     User=sonar
#     Group=sonar
#     Restart=on-failure
#
#     [Install]
#     WantedBy=multi-user.target
#     EOT'
#
#     # Start SonarQube
#     sudo systemctl daemon-reload
#     sudo systemctl enable sonar
#     sudo systemctl start sonar
#
#     # Log SonarQube installation status
#     if systemctl status sonar; then
#       echo "SonarQube installed and running." > /var/log/user-data.log
#     else
#       echo "SonarQube installation failed." > /var/log/user-data.log
#     fi
#   EOF


  tags = {
    Name        = var.instance_name
    Create_By   = "Terraform"
    Environment = var.environment
    Project     = "sonar_server"
    Company     = "DEL"
  }
}
