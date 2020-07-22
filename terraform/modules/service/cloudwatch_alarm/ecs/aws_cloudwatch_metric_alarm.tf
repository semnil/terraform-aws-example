# aws_cloudwatch_metric_alarm
resource "aws_cloudwatch_metric_alarm" "ecs_task" {
  alarm_name        = "${var.name}-ecs-task"
  alarm_description = "[ECS/SERVICE]実行中コンテナが5分間0個の場合アラート"

  # metric
  namespace   = "ECS/ContainerInsights"
  metric_name = "RunningTaskCount"
  dimensions = {
    ClusterName = var.dimensions.cluster
    ServiceName = var.dimensions.service
  }
  statistic           = "Maximum"
  period              = 60
  comparison_operator = "LessThanOrEqualToThreshold"
  threshold           = 0
  evaluation_periods  = 5
  treat_missing_data  = "breaching"

  # action
  actions_enabled = var.actions_enabled
  alarm_actions   = [var.sns_topic_arn]
  ok_actions      = [var.sns_topic_arn]

  tags = {
    Environment = var.environment
  }
}

resource "aws_cloudwatch_metric_alarm" "ecs_cpu" {
  alarm_name        = "${var.name}-ecs-cpu"
  alarm_description = "[ECS/SERVICE]CPUが5分間80％を超えた場合アラート"

  # metric
  namespace   = "AWS/ECS"
  metric_name = "CPUUtilization"
  dimensions = {
    ClusterName = var.dimensions.cluster
    ServiceName = var.dimensions.service
  }
  statistic           = "Average"
  period              = 60
  comparison_operator = "GreaterThanOrEqualToThreshold"
  threshold           = 80
  evaluation_periods  = 5
  treat_missing_data  = "ignore"

  # action
  actions_enabled = var.actions_enabled
  alarm_actions   = [var.sns_topic_arn]
  ok_actions      = [var.sns_topic_arn]

  tags = {
    Environment = var.environment
  }
}

resource "aws_cloudwatch_metric_alarm" "ecs_memory" {
  alarm_name        = "${var.name}-ecs-memory"
  alarm_description = "[ECS/SERVICE]メモリが5分間80％を超えた場合アラート"

  # metric
  namespace   = "AWS/ECS"
  metric_name = "MemoryUtilization"
  dimensions = {
    ClusterName = var.dimensions.cluster
    ServiceName = var.dimensions.service
  }
  statistic           = "Average"
  period              = 60
  comparison_operator = "GreaterThanOrEqualToThreshold"
  threshold           = 80
  evaluation_periods  = 5
  treat_missing_data  = "ignore"

  # action
  actions_enabled = var.actions_enabled
  alarm_actions   = [var.sns_topic_arn]
  ok_actions      = [var.sns_topic_arn]

  tags = {
    Environment = var.environment
  }
}
