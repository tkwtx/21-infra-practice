variable "aws_base_config" {
  type        = map(string)
  description = "Minimum AWS Config requirements."
  default     = {
    region  = "ap-northeast-1"
    profile = "default"
  }
}

variable "vpc_cidr_block" {}

variable "subnet_cidr_block" {}

variable "ec2_conf" {}

variable "ec2_private_ip" {}

variable "ec2_key_name" {}

variable "rds_conf" {}

variable "rds_user_conf" {}
