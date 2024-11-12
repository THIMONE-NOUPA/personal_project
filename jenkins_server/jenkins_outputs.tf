output "security_group_id" {
  description = "The ID of the security group allowing SSH."
  value       = aws_security_group.jenkins_ssh.id
}

output "instance_jenkins_id" {
  description = "The ID of the EC2 instance."
  value       = aws_instance.jenkins_server.id
}

