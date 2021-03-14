resource "aws_security_group" "alb_sg" {
  name        = "alb-sg"
  description = "Ingress for alb-sg"
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

resource "aws_lb_target_group" "main" {
  name     = "tf-alb-tg"
  port     = 80
  protocol = "HTTP"
  target_type = "instance"
  vpc_id   = var.vpc

  health_check {
    enabled             = true
    protocol            = "HTTP"
    path                = "/"
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    matcher             = "200"
  }
}

resource "aws_lb" "main" {
  name                = "tf-alb"
  internal            = false
  load_balancer_type  = "application"
  security_groups     = [aws_security_group.alb_sg.id]
  subnets             = [for v in lookup(var.subnet, "public") : v]

  enable_deletion_protection = true
}

resource "aws_lb_listener" "main" {
  load_balancer_arn = aws_lb.main.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn  = aws_lb_target_group.main.arn
    type              = "forward"
  }
}

resource "aws_lb_target_group_attachment" "main" {
  count            = length(var.target_instance)
  target_group_arn = aws_lb_target_group.main.arn
  target_id        = var.target_instance[count.index]
  port             = 80
}
