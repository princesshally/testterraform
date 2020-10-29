provider "aws" {
  region     = "us-east-1"
}

resource "aws_vpc" "main" {
  cidr_block       = "${var.vpc_cidr}"
  instance_tenancy = "${var.tenancy}"

  tags = {
    Name = "main"
  }
}

resource "aws_subnet" "main" {
  vpc_id     = "${var.vpc_id}"
  cidr_block = "${var.subnet_cidr}"

  tags = {
    Name = "Main"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = "${var.vpc_id}"

  tags = {
    Name = "main"
  }
}

resource "aws_route_table" "r" {
  vpc_id = "${var.vpc_id}"

  route {
    cidr_block = "${var.subnet_cidr}"
    gateway_id = "${var.igw_id}" 
  }


  tags = {
    Name = "main"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = "${var.subnet_id}"
  route_table_id = "${var.route_table_id}"
}
resource "aws_route_table_association" "b" {
  gateway_id     = "${var.igw_id}"
  route_table_id = "${var.route_table_id}"
}

resource "aws_security_group" "allow_tls" {
  name        = "${var.sg_name}"
  description = "${var.sg_description}"
  vpc_id      = "${var.vpc_id}"

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}

output "vpc_id" {
  value = "${aws_vpc.main.id}"  
}

output "subnet_id" {
  value = "${aws_subnet.main.id}"
}  
   
output "igw_id" {
  value = "${aws_internet_gateway.gw.id}"
}  
   
output "route_table_id" {
  value = "${aws_route_table.r.id}" 
}

