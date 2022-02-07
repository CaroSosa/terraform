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