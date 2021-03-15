module "vpc" {
  source    = "./../../modules/vpc"

  region    = lookup(var.aws_base_config, "region")
  vpc_cb    = var.vpc_cidr_block
  subnet_cb = var.subnet_cidr_block
}

module "ec2" {
  source  = "./../../modules/ec2"

  conf    = var.ec2_conf
  ip      = var.ec2_private_ip
  key     = var.ec2_key_name
  vpc     = module.vpc.vpc_id
  subnet  = module.vpc.subnet_id
}

module "rds" {
  source  = "./../../modules/rds"

  rds_conf  = var.rds_conf
  user_conf = var.rds_user_conf
  web_sg    = module.ec2.web_sg_id
  subnet    = module.vpc.subnet_id
  vpc       = module.vpc.vpc_id
}

module "alb" {
  source = "./../../modules/alb"

  acm             = module.acm.acm_arn
  subnet          = module.vpc.subnet_id
  vpc             = module.vpc.vpc_id
  target_instance = module.ec2.instance_ids
}

module "route53" {
  source = "./../../modules/route53"

  alb = module.alb.alb_conf
}

module "acm" {
  source = "./../../modules/acm"

  domain = var.domain_name
}

module "s3" {
  source = "./../../modules/s3"
}