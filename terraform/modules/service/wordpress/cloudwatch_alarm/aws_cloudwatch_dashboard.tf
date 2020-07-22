locals {
  public_alb = module.public_alb.cloudwatch_metric_alarm
  aurora     = module.aurora.cloudwatch_metric_alarm
  ecs        = module.ecs.cloudwatch_metric_alarm
  # Fargateに置き換え
  # ec2    = module.ec2.cloudwatch_metric_alarm
}
locals {
  # ダッシュボードに配置するウィジェット
  # 二次元配列の[x][y]が座標に対応
  dashbord_widgets_template = [
    [local.public_alb.alb_host, local.public_alb.alb_5xx],
    [local.ecs.ecs_task, local.ecs.ecs_cpu, local.ecs.ecs_memory],
    # Fargateに置き換え
    # [local.ec2.asg_total_instances, local.ec2.asg_status_failed, local.ec2.asg_cpu],
    [local.aurora.aurora_cpu, local.aurora.aurora_storage],
  ]
}

# aws_cloudwatch_dashboard
resource "aws_cloudwatch_dashboard" "wp_alert" {
  dashboard_name = "${var.prefix}-wp-alert-${var.environment}"

  dashboard_body = jsonencode(
    {
      widgets = flatten([
        for index_y, widgets in local.dashbord_widgets_template : [
          for index_x, widget in widgets : {
            type   = "metric"
            width  = 24 / length(widgets)
            height = 5
            x      = index_x * (24 / length(widgets))
            y      = index_y * 5
            properties = {
              title = widget.alarm_name
              annotations = {
                alarms = [
                  widget.arn,
                ]
              }
              stacked = false
              view    = "timeSeries"
            }
          }
        ]
      ])
    }
  )
}
