# output "ec2_private_ip" {
#   value = module.vpc.subnet_id
#   description = "Set id of the created subnet."
# }

output "subnet_to_list" {
  value = [for value in lookup(module.vpc.subnet_id, "private") : value]
}

output "web_sg_id" {
  value = module.ec2.web_sg_id
}


output "subnet" {
  value = [for v in lookup(module.vpc.subnet_id, "public") : v]
}

output "ns" {
  value = module.route53.ns_list
}

output "alb_conf" {
  value = module.alb.alb_conf
}