variable "instance_type" {
  type        = string
  default     = "t2.large"
  description = "Type of EC2 instance to use for Jenkins server"
}

variable "key_name" {
  type        = string
  default     = "key_thim"
  description = "Name of the SSH key pair to use for accessing the EC2 instance"
}

variable "instance_name" {
  type        = string
  default     = "sonar_server"
  description = "Name to assign to the EC2 instance"
}

variable "ubuntu_id" {
  type        = string
  default     = "ami-0c1e920f5365fa0c2"
  description = "Name to assign ami to the EC2 instance"
}

variable "spring_vpc" {
  description = "ID of the VPC"
  type        = string
}

variable "alb_security_group_id" {
  description = "ID of alb security group"
  type = string
}

variable "bastion_ssh" {
  description = "ID of bastion_host security group"
  type = string
}

variable "environment" {
  type        = string
  default     = "Development"
  description = "Deployment environment (e.g., Development, Staging, Production)"
}

variable "spring_private_subnet" {
  description = "ID du sous-réseau privé"
  type        = string
}


variable "aws_nat_gateway" {}
variable "aws_route_table" {}
variable "aws_route_table_association" {}
