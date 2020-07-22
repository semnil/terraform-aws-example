output "cloudwatch_log_group" {
  value = {
    wp = aws_cloudwatch_log_group.wp
  }
}
