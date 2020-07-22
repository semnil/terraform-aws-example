# aws_autoscaling_group
resource "aws_autoscaling_group" "wp" {
  name                 = "${var.prefix}-wp-${var.environment}"
  max_size             = var.max_size
  min_size             = var.min_size
  desired_capacity     = var.desired_capacity
  vpc_zone_identifier  = var.subnet_ids
  launch_configuration = aws_launch_configuration.wp.name
  health_check_type    = "ELB"

  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupPendingInstances",
    "GroupStandbyInstances",
    "GroupTerminatingInstances",
    "GroupTotalInstances",
  ]

  termination_policies = [
    "OldestLaunchConfiguration",
    "OldestInstance",
    "Default",
  ]

  tag {
    key                 = "Name"
    value               = "${var.prefix}-wp-${var.environment}"
    propagate_at_launch = true
  }
  tag {
    key                 = "Environment"
    value               = var.environment
    propagate_at_launch = true
  }

  lifecycle {
    ignore_changes = [desired_capacity]
  }
}
