# aws_autoscaling_schedule
resource "aws_autoscaling_schedule" "wp_start" {
  autoscaling_group_name = aws_autoscaling_group.wp.name
  scheduled_action_name  = "DailyStart"
  min_size               = -1
  max_size               = -1
  desired_capacity       = 1
  recurrence             = "50 23 * * *"
}

resource "aws_autoscaling_schedule" "wp_stop" {
  autoscaling_group_name = aws_autoscaling_group.wp.name
  scheduled_action_name  = "DailyStop"
  min_size               = -1
  max_size               = -1
  desired_capacity       = 0
  recurrence             = "0 12 * * *"
}
