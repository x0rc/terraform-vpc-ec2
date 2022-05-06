provider "aws" {
    region = var.aws_region
}

resource "aws_vpc" "prod-vpc" {
	cidr_block		 = var.vpc_cidr
	instance_tenancy = "default"

	tags = {
	  Name = var.vpc_tag
	}

}

#creating subnet-1
resource "aws_subnet" "prod-subnet-1" {
  vpc_id     = aws_vpc.prod-vpc.id
  cidr_block = var.subnet_cidr
  availability_zone = "${var.aws_region}a"

  tags = {
    Name = var.subnet_tag
  }
}

#creating internet gateway 
resource "aws_internet_gateway" "igw" {
	vpc_id = aws_vpc.prod-vpc.id

	tags = {
	  Name = "prod-igw"
	}

}

#creating route_table 
resource "aws_route_table" "prod-rt" {
  vpc_id = aws_vpc.prod-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

   tags = {
    Name = "public-rt"
  }
}

#associating subnet to route table
resource "aws_route_table_association" "subnet-associate" {
  subnet_id      = aws_subnet.prod-subnet-1.id
  route_table_id = aws_route_table.prod-rt.id
}

#security group for ports ssh-22, http-80, https-443, change SSH cidr_block to personal ip for more security
resource "aws_security_group" "prod-sg" {
  name        = var.sg_name
  description = "Allow web inbound traffic"
  vpc_id      = aws_vpc.prod-vpc.id

  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "HTTPS"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = var.sg_tag
  }
}

