resource "aws_lb_listener_rule" "parser" {
  # depends_on   = [module.private_alb_parser]
  listener_arn = aws_lb_listener.private_alb_http.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.parser.arn
  }

  condition {
    field  = "host-header"
    values = ["parser.${var.domain_name}.local"]
    # values = [module.private_alb_parser.route53_record.name]
  }
}
