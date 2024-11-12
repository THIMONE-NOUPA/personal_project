
output "aws_internet_gateway" {
  value = aws_internet_gateway.spring_internet_gateway.id
}

output "aws_nat_gateway" {
  value = aws_nat_gateway.spring_nat_gateway.id
}

output "aws_subnet" {
  value =  {
        private_subnet = aws_subnet.spring_private_subnet.id
        private_subnet2 = aws_subnet.spring_private_subnet_2.id
        public_subnet  = aws_subnet.spring_public_subnet.id
        public_subnet2  = aws_subnet.spring_public_subnet_2.id
  }
}


output "aws_route_table" {
    value = {
        public_route_table = aws_route_table.spring_public_route_table.id
        private_route_table = aws_route_table.spring_private_route_table.id
    }
}

output "aws_route_table_association" {
    value = {
  public_route_table_association = aws_route_table_association.spring_public_route_association.id
  private_route_table_association = aws_route_table_association.spring_private_route_association.id
    }
}

output "spring_vpc" {
  value = aws_vpc.spring_vpc.id  # Remplacez par le nom de votre ressource VPC
}

output "alb_security_group_id" {
  value = aws_security_group.alb_security_group.id
}