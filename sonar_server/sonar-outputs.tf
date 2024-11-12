output "security_group_id" {
  description = "The ID of the security group allowing SSH."
  value       = aws_security_group.sonarqube_sg.id
}

output "instance_sonar_id" {
  description = "The ID of the EC2 instance."
  value       = aws_instance.sonar_server.id
}