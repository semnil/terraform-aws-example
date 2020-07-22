# aws_cloudwatch_metric_alarm
resource "aws_cloudwatch_metric_alarm" "asg_total_instances" {
  alarm_name        = "${var.name}-asg-total-instances"
  alarm_description = "[EC2/ASG]正常なインスタンスが5分間0台の場合アラート"

  # metric
  namespace   = "AWS/AutoScaling"
  metric_name = "GroupTotalInstances"
  dimensions = {
    AutoScalingGroupName = var.dimensions.autoscaling_group
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

resource "aws_cloudwatch_metric_alarm" "asg_status_failed" {
  alarm_name        = "${var.name}-asg-status-failed"
  alarm_description = "[EC2/ASG]インスタンスがステータス失敗の場合アラート"

  # metric
  namespace   = "AWS/EC2"
  metric_name = "StatusCheckFailed"
  dimensions = {
    AutoScalingGroupName = var.dimensions.autoscaling_group
  }
  statistic           = "Maximum"
  period              = 60
  comparison_operator = "GreaterThanOrEqualToThreshold"
  threshold           = 1
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

resource "aws_cloudwatch_metric_alarm" "asg_cpu" {
  alarm_name        = "${var.name}-asg-cpu"
  alarm_description = "[EC2/ASG]CPUが5分間80％を超えた場合アラート"

  # metric
  namespace   = "AWS/EC2"
  metric_name = "CPUUtilization"
  dimensions = {
    AutoScalingGroupName = var.dimensions.autoscaling_group
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
