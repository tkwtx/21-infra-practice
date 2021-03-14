variable "alb" {}

output "ns_list" {
  value = aws_route53_zone.main.name_servers
}
