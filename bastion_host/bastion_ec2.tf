variable "spring_public_subnet" {
  description = "ID du sous-réseau public pour bastion_host"
  type        = string
}


resource "aws_instance" "bastion_host" {
  depends_on = [
    aws_security_group.bastion_ssh
  ]

  ami = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.bastion_ssh.id]
  subnet_id              = var.spring_public_subnet  # Référence le subnet public
  associate_public_ip_address = true  # active l'IP publique


 
  tags = {
    Name        = var.instance_name
    Create_By   = "Terraform"
    Environment = var.environment
    Project     = "bastion_host"
    Company     = "DEL"
  }
}
