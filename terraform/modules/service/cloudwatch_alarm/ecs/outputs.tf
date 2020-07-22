output "cloudwatch_metric_alarm" {
  value = {
    ecs_task   = aws_cloudwatch_metric_alarm.ecs_task
    ecs_cpu    = aws_cloudwatch_metric_alarm.ecs_cpu
    ecs_memory = aws_cloudwatch_metric_alarm.ecs_memory
  }
}
