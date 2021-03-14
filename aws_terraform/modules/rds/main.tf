locals {
  username = lookup(var.user_conf, "username")
  password = lookup(var.user_conf, "password")
}

resource "aws_db_subnet_group" "main" {
  name        = "tf-rds-sg"
  subnet_ids  = [for v in lookup(var.subnet, "private") : v]
}

resource "aws_db_parameter_group" "main" {
  name    = "tf-rds-pg"
  family  = lookup(lookup(var.rds_conf, "parameter_group"), "family")
  
  dynamic "parameter" {
    for_each = lookup(lookup(var.rds_conf, "parameter_group"), "parameter")
    content {
      name  = parameter.value.name
      value = parameter.value.val
    }
  }
}

resource "aws_db_option_group" "main" {
  name                  = "tf-rds-og"
  engine_name           = lookup(lookup(var.rds_conf, "option_group"), "engine_name")
  major_engine_version  = lookup(lookup(var.rds_conf, "option_group"), "major_engine_version")
}

resource "aws_security_group" "db_sg" {
  name        = "db-sg"
  description = "Ingress for db-sg"
  vpc_id      = var.vpc

  ingress {
    description     = "Mysql from web-sg"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [var.web_sg]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_instance" "main" {
  allocated_storage     = 10
  availability_zone     = "ap-northeast-1a"
  apply_immediately     = true
  engine                = lookup(lookup(var.rds_conf, "rds"), "engine")
  engine_version        = lookup(lookup(var.rds_conf, "rds"), "engine_version")
  instance_class        = lookup(lookup(var.rds_conf, "rds"), "instance_class")
  name                  = "web"
  username              = lookup(var.user_conf, "username")
  password              = lookup(var.user_conf, "password")
  port                  = 3306
  skip_final_snapshot   = true
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  db_subnet_group_name  = aws_db_subnet_group.main.id
  option_group_name     = aws_db_option_group.main.id
  parameter_group_name  = aws_db_parameter_group.main.id
}