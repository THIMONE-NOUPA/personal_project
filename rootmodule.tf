# main.tf

module "spring_network" {
  source              = "./spring_network"
  instance_jenkins_id = module.jenkins_server.instance_jenkins_id
  instance_sonar_id   = module.sonar_server.instance_sonar_id
}

module "jenkins_server" {
  source                      = "./jenkins_server"
  aws_nat_gateway             = module.spring_network.aws_nat_gateway
  aws_route_table             = module.spring_network.aws_route_table
  aws_route_table_association = module.spring_network.aws_route_table_association
  # Passer l'ID du sous-réseau privé
  spring_private_subnet = module.spring_network.aws_subnet.private_subnet
  spring_vpc            = module.spring_network.spring_vpc # Passer l'ID du VPC
  alb_security_group_id = module.spring_network.alb_security_group_id
  bastion_ssh           = module.bastion_host.bastion_ssh
  # autres variables nécessaires
}

module "sonar_server" {
  source                      = "./sonar_server"
  aws_nat_gateway             = module.spring_network.aws_nat_gateway
  aws_route_table             = module.spring_network.aws_route_table
  aws_route_table_association = module.spring_network.aws_route_table_association
  # Passer l'ID du sous-réseau privé
  spring_private_subnet = module.spring_network.aws_subnet.private_subnet
  spring_vpc            = module.spring_network.spring_vpc # Passer l'ID du VPC
  alb_security_group_id = module.spring_network.alb_security_group_id
  bastion_ssh           = module.bastion_host.bastion_ssh
}

module "bastion_host" {
  source                      = "./bastion_host"
  aws_internet_gateway        = module.spring_network.aws_internet_gateway
  aws_route_table             = module.spring_network.aws_route_table
  aws_route_table_association = module.spring_network.aws_route_table_association
  # Passer l'ID du sous-réseau public
  spring_public_subnet = module.spring_network.aws_subnet.public_subnet
  spring_vpc           = module.spring_network.spring_vpc # Passer l'ID du VPC
}

terraform {
  backend "s3" {
    bucket         = "thims3"                             # Your S3 bucket name
    key            = "terraform/spring/terraform.tfstate" # Path to the state file in the bucket
    region         = "us-east-1"                          # This should match where the bucket is located
    dynamodb_table = "springdynamodb"                     # Your DynamoDB table for state locking
    encrypt        = true                                 # Optional: Enable encryption for state
  }
}

provider "aws" {
  region = "us-east-1" # Matches the S3 bucket
}
