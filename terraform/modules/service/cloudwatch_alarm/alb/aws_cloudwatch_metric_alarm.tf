# aws_cloudwatch_metric_alarm
resource "aws_cloudwatch_metric_alarm" "alb_host" {
  alarm_name        = "${var.name}-alb-host-count"
  alarm_description = "[ALB/TG]正常なホストが5分間0台の場合アラート"

  # metric
  namespace   = "AWS/ApplicationELB"
  metric_name = "HealthyHostCount"
  dimensions = {
    LoadBalancer = var.dimensions.alb
    TargetGroup  = var.dimensions.target_group
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

resource "aws_cloudwatch_metric_alarm" "alb_5xx" {
  alarm_name        = "${var.name}-alb-5XX"
  alarm_description = "[ALB/TG]5XXが5分間5回以上の場合アラート"

  # metric
  namespace   = "AWS/ApplicationELB"
  metric_name = "HTTPCode_Target_5XX_Count"
  dimensions = {
    LoadBalancer = var.dimensions.alb
    TargetGroup  = var.dimensions.target_group
  }
  statistic           = "Sum"
  period              = 300
  comparison_operator = "GreaterThanOrEqualToThreshold"
  threshold           = 5
  evaluation_periods  = 1
  treat_missing_data  = "notBreaching"

  # action
  actions_enabled = var.actions_enabled
  alarm_actions   = [var.sns_topic_arn]
  ok_actions      = [var.sns_topic_arn]

  tags = {
    Environment = var.environment
  }
}

# 試しに書いて必要になったら使う用
# resource "aws_cloudwatch_metric_alarm" "alb_error_rate" {
#   alarm_name = "${var.name}-alb-error-rate"
#   alarm_description = "[ALB/TG]エラー率が10%以上の場合アラート"
#
#   # metric
#   comparison_operator = "GreaterThanOrEqualToThreshold"
#   evaluation_periods  = "2"
#   threshold           = "10"
#   alarm_description   = "Request error rate has exceeded 10%"
#
#   metric_query {
#     id          = "e1"
#     expression  = "m2/m1*100"
#     label       = "Error Rate"
#     return_data = "true"
#   }
#
#   metric_query {
#     id = "m1"
#
#     metric {
#       namespace   = "AWS/ApplicationELB"
#       metric_name = "RequestCount"
#       period      = "120"
#       stat        = "Sum"
#       unit        = "Count"
#
#       dimensions = {
#         LoadBalancer = var.dimensions.alb
#       }
#     }
#   }
#
#   metric_query {
#     id = "m2"
#
#     metric {
#       namespace   = "AWS/ApplicationELB"
#       metric_name = "HTTPCode_ELB_5XX_Count"
#       period      = "120"
#       stat        = "Sum"
#       unit        = "Count"
#
#       dimensions = {
#         LoadBalancer = var.dimensions.alb
#       }
#     }
#   }
#
#   # action
#   actions_enabled = var.actions_enabled
#   alarm_actions   = [var.sns_topic_arn]
#   ok_actions      = [var.sns_topic_arn]
#
#   tags = {
#     Environment = var.environment
#   }
# }
