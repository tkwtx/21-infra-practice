resource "aws_route53_zone" "main" {
  name = "isseeeeeeeey.com" 
}

resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "isseeeeeeeey.com"
  type    = "A"

  alias {
    name                    = lookup(var.alb, "dns_name")
    zone_id                 = lookup(var.alb, "zone_id")
    evaluate_target_health  = true
  }
}
