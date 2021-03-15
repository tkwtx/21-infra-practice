resource "aws_acm_certificate" "main" {
  domain_name = var.domain
  validation_method = "EMAIL"

  tags = {
    Name = "tf-acm"
  }
}

resource "aws_acm_certificate_validation" "cert" {
  certificate_arn = aws_acm_certificate.main.arn
}