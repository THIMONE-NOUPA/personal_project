variable "instance_type" {
  type        = string
  default     = "t2.large"
  description = "Type of EC2 instance to use for bastion_host"
}

variable "key_name" {
  type        = string
  default     = "key_thim"
  description = "Name of the SSH key pair to use for accessing the EC2 instance"
}

variable "instance_name" {
  type        = string
  default     = "bastion_host"
  description = "Name to assign to the EC2 instance"
}


variable "environment" {
  type        = string
  default     = "Development"
  description = "Deployment environment (e.g., Development, Staging, Production)"
}


variable "aws_internet_gateway" {}
variable "aws_route_table" {}
variable "aws_route_table_association" {}

