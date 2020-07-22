resource "aws_lb_target_group" "wp" {
  name                 = "${var.prefix}-wp-${var.environment}"
  vpc_id               = var.vpc_id
  target_type          = "ip"
  deregistration_delay = 300
  port                 = 80
  protocol             = "HTTP" # HTTPSの終端はALBで行う

  health_check {
    path                = "/"
    healthy_threshold   = 2
    unhealthy_threshold = 10
    timeout             = 60
    interval            = 300
    matcher             = "200,301,302" # wordpress未インストール状態では30xリダイレクトを返すため
    port                = 80
    protocol            = "HTTP"
  }

  tags = {
    Environment = var.environment
  }
}
