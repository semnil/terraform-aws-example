resource "aws_lb_target_group" "app" {
  depends_on           = [aws_lb.public_alb]
  name                 = "${var.prefix}-app-${var.environment}"
  vpc_id               = var.vpc_id
  target_type          = "ip"
  deregistration_delay = 300
  port                 = 3000
  protocol             = "HTTP" # HTTPSの終端はALBで行う

  health_check {
    path                = "/health_check"
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    matcher             = 200
    port                = "traffic-port"
    protocol            = "HTTP"
  }

  tags = {
    Environment = var.environment
  }
}

resource "aws_lb_target_group" "parser" {
  depends_on           = [aws_lb.private_alb]
  name                 = "${var.prefix}-parser-${var.environment}"
  vpc_id               = var.vpc_id
  target_type          = "ip"
  deregistration_delay = 300
  port                 = 3000
  protocol             = "HTTP"

  health_check {
    path                = "/health_check"
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    matcher             = 200
    port                = "traffic-port"
    protocol            = "HTTP"
  }

  tags = {
    Environment = var.environment
  }
}
