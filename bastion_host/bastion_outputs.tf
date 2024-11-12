output "security_group_id" {
  description = "The ID of the security group allowing SSH."
  value       = aws_security_group.bastion_ssh.id
}

output "instance_bastion_host_id" {
  description = "The ID of the EC2 instance."
  value       = aws_instance.bastion_host.id
}

output "bastion_ssh" {
  value = aws_security_group.bastion_ssh.id
}