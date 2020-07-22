output "autoscaling_group" {
  value = {
    worker = aws_autoscaling_group.worker
  }
}
