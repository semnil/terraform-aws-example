output "lb_listener_rule" {
  value = {
    wp = aws_lb_listener_rule.wp
  }
}

output "lb_target_group" {
  value = {
    wp = aws_lb_target_group.wp
  }
}
