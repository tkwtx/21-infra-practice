terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region  = lookup(var.aws_base_config, "region")
  profile = lookup(var.aws_base_config, "profile")
}
