output "autoscaling_group" {
  value = {
    wp = aws_autoscaling_group.wp
  }
}
