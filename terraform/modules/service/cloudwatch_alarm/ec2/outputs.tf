output "cloudwatch_metric_alarm" {
  value = {
    asg_total_instances = aws_cloudwatch_metric_alarm.asg_total_instances
    asg_status_failed   = aws_cloudwatch_metric_alarm.asg_status_failed
    asg_cpu             = aws_cloudwatch_metric_alarm.asg_cpu
  }
}
