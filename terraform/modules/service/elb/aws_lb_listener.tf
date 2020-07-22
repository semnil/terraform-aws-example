# aws_lb_listener
resource "aws_lb_listener" "public_alb_http" {
  load_balancer_arn = aws_lb.public_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.app.arn
    type             = "forward"
  }
}

# resource "aws_lb_listener" "public_alb_https" {
#   load_balancer_arn = aws_lb.public_alb.arn
#   port              = "443"
#   protocol          = "HTTPS"
#   certificate_arn   = var.certificate_arn
#   ssl_policy        = "ELBSecurityPolicy-2016-08"
#
#   default_action {
#     target_group_arn = aws_lb_target_group.app.arn
#     type             = "forward"
#   }
# }

resource "aws_lb_listener" "private_alb_http" {
  load_balancer_arn = aws_lb.private_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      status_code  = "503"
    }
  }
}
