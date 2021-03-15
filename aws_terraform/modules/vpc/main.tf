locals {
  az_1a = "${var.region}a"
  az_1c = "${var.region}c"
}

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cb

  tags = {
    Name = "tf-vpc"
  }
}

resource "aws_subnet" "pub_1a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = lookup(lookup(var.subnet_cb, "public"), local.az_1a)
  availability_zone = local.az_1a

  tags = {
    Name = "tf-publc-subnet-1a"
  }
}

resource "aws_subnet" "pub_1c" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = lookup(lookup(var.subnet_cb, "public"), local.az_1c)
  availability_zone = local.az_1c

  tags = {
    Name = "tf-publc-subnet-1c"
  }
}

resource "aws_subnet" "pri_1a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = lookup(lookup(var.subnet_cb, "private"), local.az_1a)
  availability_zone = local.az_1a

  tags = {
    Name = "tf-private-subnet-1a"
  }
}

resource "aws_subnet" "pri_1c" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = lookup(lookup(var.subnet_cb, "private"), local.az_1c)
  availability_zone = local.az_1c

  tags = {
    Name = "tf-private-subnet-1c"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "tf-igw"
  }
}

resource "aws_route_table" "route_igw" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "tf-public-route"
  }
}

resource "aws_route_table_association" "pub_1a" {
  subnet_id       = aws_subnet.pub_1a.id
  route_table_id  = aws_route_table.route_igw.id
}

resource "aws_route_table_association" "pub_1c" {
  subnet_id       = aws_subnet.pub_1c.id
  route_table_id  = aws_route_table.route_igw.id
}
