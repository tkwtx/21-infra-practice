locals {
  az_1a = "ap-northeast-1a"
  az_1c = "ap-northeast-1c"
}

resource "aws_instance" "web01" {
  ami                         = lookup(var.conf, "ami_id")
  instance_type               = lookup(var.conf, "instance_type")
  subnet_id                   = lookup(lookup(var.subnet, "public"), local.az_1a)
  private_ip                  = lookup(lookup(var.ip, "public"), local.az_1a)
  key_name                    = var.key
  vpc_security_group_ids      = [aws_security_group.web_sg.id]
  associate_public_ip_address = true

  tags = {
    Name = "tf-web01"
  }
}

resource "aws_instance" "web02" {
  ami                         = lookup(var.conf, "ami_id")
  instance_type               = lookup(var.conf, "instance_type")
  subnet_id                   = lookup(lookup(var.subnet, "public"), local.az_1c)
  private_ip                  = lookup(lookup(var.ip, "public"), local.az_1c)
  key_name                    = var.key
  vpc_security_group_ids      = [aws_security_group.web_sg.id]
  associate_public_ip_address = true

  tags = {
    Name = "tf-web02"
  }
}

resource "aws_eip" "web01" {
  vpc      = true
  instance = aws_instance.web01.id
}

resource "aws_eip" "web02" {
  vpc      = true
  instance = aws_instance.web02.id
}

resource "aws_security_group" "web_sg" {
  name        = "web-sg"
  description = "Ingress for web-sg"
  vpc_id      = var.vpc

  dynamic "ingress" {
    for_each = var.security_group_ingress_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}