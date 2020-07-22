# aws_cloudwatch_metric_alarm
resource "aws_cloudwatch_metric_alarm" "aurora_cpu" {
  alarm_name        = "${var.name}-aurora-cpu"
  alarm_description = "[AURORA]CPUが5分間80％を超えた場合アラート"

  # metric
  namespace   = "AWS/RDS"
  metric_name = "CPUUtilization"
  dimensions = {
    DBClusterIdentifier = var.dimensions.cluster
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

resource "aws_cloudwatch_metric_alarm" "aurora_storage" {
  alarm_name        = "${var.name}-aurora-storage"
  alarm_description = "[AURORA]ローカルストレージが5GBを下回った場合アラート"

  # metric
  namespace   = "AWS/RDS"
  metric_name = "FreeLocalStorage"
  dimensions = {
    DBClusterIdentifier = var.dimensions.cluster
  }
  statistic           = "Average"
  period              = 300
  comparison_operator = "LessThanOrEqualToThreshold"
  threshold           = 5 * pow(1000, 3) # GB
  evaluation_periods  = 1
  treat_missing_data  = "ignore"

  # action
  actions_enabled = var.actions_enabled
  alarm_actions   = [var.sns_topic_arn]
  ok_actions      = [var.sns_topic_arn]

  tags = {
    Environment = var.environment
  }
}
