provider "aws" {
  region = "ap-south-1"
}
#creating VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "{$var.project}-vpc"
    env = var.env
  }
}
#creating private subnet
resource "aws_subnet" "private_subnet" {
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = var.private_subnet_cidr 
  tags = {
    Name = "{$var.project}-private-subnet"
    env = var.env
  }
}

#creating public subnet
resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = var.public_subnet_cidr
  map_public_ip_on_launch = true 
  tags = {
    Name = "{$var.project}-public-subnet"
    env = var.env
  }
}

#creating internet gateway
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "{$var.project}-tgw"
  }
}

#creating route table
resource "aws_route" "my_route" {
  route_table_id = aws_vpc.my_vpc.default_route_table_id
  destination_cidr_block = ["0.0.0.0/0"]
  gateway_id = aws_internet_gateway.my_igw

}

#creating security group
resource "aws_security_group" "my_security" {
  name = "{$var.project}-sg"
  description = "project-sg"
  vpc_id = aws_vpc.my_vpc.id
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol = "TCP"
    from_port = 22
    to_port = 22
  }  
  ingress = {
    cidr_blocks = ["0.0.0.0/0"]
    protocol = "TCP"
    from_port = 80
    to_port = 80
  }
  egress = {
    cidr_blocks = "[0.0.0.0/0]"
    protocol = "-1"
    from_port = 0
    to_port = 0
  }
}

#creating public instance
resource "aws_instance" "private_instance" {
  ami = var.instance_id
  instance_type = var.instance_type
  key_name = var.key_name
  vpc_security_group_ids = [aws_security_group.my_security.id]
  subnet_id = aws_subnet.private_subnet.id
  tags = {
    Name = "{$var.project}-private-instance"
    env = "{$var.env}"
  }
}

#creating private instance
resource "aws_instance" "public_instance" {
  ami = var.instance_id
  instance_type = var.instance_type
  key_name = var.key_name
  vpc_security_group_ids = [aws_security_group.my_security.id]
  subnet_id = aws_subnet.public_subnet.id
  tags = {
    Name = "{var.project}-public-instance"
    env = "{var.env}"
  }
}