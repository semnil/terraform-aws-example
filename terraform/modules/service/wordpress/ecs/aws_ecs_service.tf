# aws_ecs_service
resource "aws_ecs_service" "wp" {
  name            = "${var.prefix}-wp-${var.environment}"
  cluster         = aws_ecs_cluster.wp.arn
  task_definition = aws_ecs_task_definition.wp.arn
  desired_count   = var.task_config.desired_count
  launch_type     = "FARGATE"
  propagate_tags  = "SERVICE"

  platform_version = "1.4.0"

  network_configuration {
    assign_public_ip = false
    security_groups  = [var.task_config.security_group_id]
    subnets          = var.task_config.subnet_ids
  }

  load_balancer {
    target_group_arn = var.task_config.target_group_arn
    container_name   = "${var.prefix}-wp"
    container_port   = 80
  }

  tags = {
    Environment = var.environment
  }
}
