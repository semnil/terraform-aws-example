output "cloudwatch_metric_alarm" {
  value = {
    aurora_cpu     = aws_cloudwatch_metric_alarm.aurora_cpu
    aurora_storage = aws_cloudwatch_metric_alarm.aurora_storage
  }
}
