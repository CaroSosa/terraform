/////////////VPC
resource "aws_vpc" "vpc" {
  cidr_block= var.cidr_block
  tags = {
    Name = var.Name
  }
}
////////////SUBNETS
/*publicas*/
resource "aws_subnet" "subnet-publica-1" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.cidr_block_subnet[0]
  availability_zone = var.availability_zone[0]
  tags = {
    Name = var.Name_subnet[0]
  }
}

resource "aws_subnet" "subnet-publica-2" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.cidr_block_subnet[1]
  availability_zone = var.availability_zone[1]
  tags = {
    Name = var.Name_subnet[1]
  }
}
/*privadas*/
resource "aws_subnet" "subnet-privada-1" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.cidr_block_subnet[2]
  availability_zone = var.availability_zone[0]
  tags = {
    Name = var.Name_subnet[2]
  }
}

resource "aws_subnet" "subnet-privada-2" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.cidr_block_subnet[3]
  availability_zone = var.availability_zone[1]
  tags = {
    Name = var.Name_subnet[3]
  }
}

/////////////INTERNET GATEWAY
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = var.Name_IGW
  }
}
///////////////NAT
resource "aws_nat_gateway" "nat-1" {
  allocation_id = aws_eip.elastic-ip-1.id
  subnet_id     = aws_subnet.subnet-publica-1.id
  connectivity_type = var.connectivity_type
  tags = {
    Name = var.Name-NAT[0]
  }
  depends_on = [aws_internet_gateway.gw]
}
resource "aws_nat_gateway" "nat-2" {
  allocation_id = aws_eip.elastic-ip-2.id
  subnet_id     = aws_subnet.subnet-publica-2.id
  connectivity_type = var.connectivity_type
  tags = {
    Name = var.Name-NAT[1]
  }
  depends_on = [aws_internet_gateway.gw]
}

//////////////ELASTIC IPs
resource "aws_eip" "elastic-ip-1" {
  vpc = true
  tags = {
  Name = "EI-1"
  }
} 

resource "aws_eip" "elastic-ip-2" {
  vpc = true
  tags = {
  Name = "EI-2"
  }
} 
////////////ROUTE TABLES
resource "aws_route_table" "rt-private-tf-1" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat-1.id
  }

  tags = {
    Name = "rt-private-tf-1"
  }
}
resource "aws_route_table" "rt-private-tf-2" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat-2.id
  }

  tags = {
    Name = "rt-private-tf-2"
  }
}
resource "aws_route_table" "rt-public-tf" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "rt-public-tf"
  }
}


resource "aws_route_table_association" "public-1" {
  subnet_id      = aws_subnet.subnet-publica-1.id
  route_table_id = aws_route_table.rt-public-tf.id
}
resource "aws_route_table_association" "public-2" {
  subnet_id      = aws_subnet.subnet-publica-2.id
  route_table_id = aws_route_table.rt-public-tf.id
}

resource "aws_route_table_association" "private-1" {
  subnet_id      = aws_subnet.subnet-privada-1.id
  route_table_id = aws_route_table.rt-private-tf-1.id
}
resource "aws_route_table_association" "private-2" {
  subnet_id      = aws_subnet.subnet-privada-2.id
  route_table_id = aws_route_table.rt-private-tf-2.id
}
