locals {
  alb_conf = {
    zone_id   = aws_lb.main.zone_id
    dns_name  = aws_lb.main.dns_name
  }
}

output "alb_conf" {
  value = local.alb_conf
}