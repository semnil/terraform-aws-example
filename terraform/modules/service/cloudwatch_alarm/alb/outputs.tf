output "cloudwatch_metric_alarm" {
  value = {
    alb_host = aws_cloudwatch_metric_alarm.alb_host
    alb_5xx  = aws_cloudwatch_metric_alarm.alb_5xx
  }
}
