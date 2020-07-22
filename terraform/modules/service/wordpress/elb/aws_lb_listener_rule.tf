resource "aws_lb_listener_rule" "wp" {
  listener_arn = var.lb_listener_arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.wp.arn
  }

  condition {
    field  = "host-header"
    values = ["wordpress.${var.domain_name}"]
  }
}
