# Define a VPC
resource "aws_vpc" "spring_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "spring_vpc"
  }
}

# Define an internet gateway for public subnet
resource "aws_internet_gateway" "spring_internet_gateway" {
  vpc_id = aws_vpc.spring_vpc.id

  tags = {
    Name = "spring_internet_gateway"
  }
}

# Define a public subnet
resource "aws_subnet" "spring_public_subnet" {
  vpc_id                  = aws_vpc.spring_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a" # Change to your desired region
  map_public_ip_on_launch = true

  tags = {
    Name = "spring_public_subnet"
  }
}

# Define a second public subnet in a different availability zone
resource "aws_subnet" "spring_public_subnet_2" {
  vpc_id                  = aws_vpc.spring_vpc.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "us-east-1b"  # Different availability zone
  map_public_ip_on_launch = true

  tags = {
    Name = "spring_public_subnet_2"
  }
}

# Define a private subnet
resource "aws_subnet" "spring_private_subnet" {
  vpc_id            = aws_vpc.spring_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1a" # Change to your desired region

  tags = {
    Name = "spring_private_subnet"
  }
}

# Define a second private subnet in a different availability zone
resource "aws_subnet" "spring_private_subnet_2" {
  vpc_id            = aws_vpc.spring_vpc.id
  cidr_block        = "10.0.4.0/24"          # CIDR différent pour éviter le chevauchement
  availability_zone = "us-east-1b"           # Différente zone de disponibilité

  tags = {
    Name = "spring_private_subnet_2"
  }
}

# Define an Elastic IP for the NAT Gateway (for the public subnet)
resource "aws_eip" "spring_nat_eip" {
  domain   = "vpc"

  tags = {
    Name = "spring_nat_eip"
  }
}

# Define a NAT Gateway in the public subnet
resource "aws_nat_gateway" "spring_nat_gateway" {
  allocation_id = aws_eip.spring_nat_eip.id
  subnet_id     = aws_subnet.spring_public_subnet.id

  tags = {
    Name = "spring_nat_gateway"
  }
}

# Define a route table for the public subnet to allow internet access
resource "aws_route_table" "spring_public_route_table" {
  vpc_id = aws_vpc.spring_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.spring_internet_gateway.id
  }

  tags = {
    Name = "spring_public_route_table"
  }
}

# Define a route table for the public subnet to allow internet access
resource "aws_route_table" "spring_public_route_table_2" {
  vpc_id = aws_vpc.spring_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.spring_internet_gateway.id
  }

  tags = {
    Name = "spring_public_route_table_2"
  }
}

# Define a route table for the private subnet to route traffic via NAT Gateway
resource "aws_route_table" "spring_private_route_table" {
  vpc_id = aws_vpc.spring_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.spring_nat_gateway.id
  }

  tags = {
    Name = "spring_private_route_table"
  }
}

# Define a route table for the second private subnet to route traffic via NAT Gateway
resource "aws_route_table" "spring_private_route_table_2" {
  vpc_id = aws_vpc.spring_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.spring_nat_gateway.id
  }

  tags = {
    Name = "spring_private_route_table_2"
  }
}

# Associate the private route table with the private subnet
resource "aws_route_table_association" "spring_private_route_association" {
  subnet_id      = aws_subnet.spring_private_subnet.id
  route_table_id = aws_route_table.spring_private_route_table.id
}

# Associate the private route table 2 with the private subnet 2
resource "aws_route_table_association" "spring_private_route_association_2" {
  subnet_id      = aws_subnet.spring_private_subnet_2.id
  route_table_id = aws_route_table.spring_private_route_table_2.id
}

# Associate the public route table 2 with the public subnet 2
resource "aws_route_table_association" "spring_public_route_association_2" {
  subnet_id      = aws_subnet.spring_public_subnet_2.id
  route_table_id = aws_route_table.spring_public_route_table_2.id
}

# Associate the public route table with the public subnet
resource "aws_route_table_association" "spring_public_route_association" {
  subnet_id      = aws_subnet.spring_public_subnet.id
  route_table_id = aws_route_table.spring_public_route_table.id
}