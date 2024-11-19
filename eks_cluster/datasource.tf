# Récupérer les informations sur le VPC
data "aws_vpc" "spring_vpc" {
  filter {
    name   = "tag:Name"
    values = ["spring_vpc"] # Nom du VPC
  }
}

# Récupérer les sous-réseaux publics
data "aws_subnet" "spring_public_subnet" {
  filter {
    name   = "tag:Name"
    values = ["spring_public_subnet"] # Nom du sous-réseau public
  }

  vpc_id = data.aws_vpc.spring_vpc.id
}

data "aws_subnet" "spring_public_subnet_2" {
  filter {
    name   = "tag:Name"
    values = ["spring_public_subnet_2"] # Nom du sous-réseau public 2
  }

  vpc_id = data.aws_vpc.spring_vpc.id
}






# Récupérer les sous-réseaux privés
data "aws_subnet" "spring_private_subnet_2" {
  filter {
    name   = "tag:Name"
    values = ["spring_private_subnet_2"] # Nom du sous-réseau privé
  }

  vpc_id = data.aws_vpc.spring_vpc.id
}

# Outputs pour déboguer et vérifier les IDs
output "spring_public_subnet_id" {
  value = data.aws_subnet.spring_public_subnet.id
}

output "spring_public_subnet_2_id" {
  value = data.aws_subnet.spring_public_subnet_2.id
}

output "spring_private_subnet_2_id" {
  value = data.aws_subnet.spring_private_subnet_2.id
}
