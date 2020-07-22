locals {
  # Track the latest ACTIVE revision
  latest_task_definition_app = format("arn:aws:ecs:${var.aws_region}:${var.account_id}:task-definition/%s:%d",
    aws_ecs_task_definition.app.family,
    max(aws_ecs_task_definition.app.revision, data.aws_ecs_task_definition.app.revision),
  )
  latest_task_definition_worker = format("arn:aws:ecs:${var.aws_region}:${var.account_id}:task-definition/%s:%d",
    aws_ecs_task_definition.worker.family,
    max(aws_ecs_task_definition.worker.revision, data.aws_ecs_task_definition.worker.revision),
  )
  latest_task_definition_parser = format("arn:aws:ecs:${var.aws_region}:${var.account_id}:task-definition/%s:%d",
    aws_ecs_task_definition.parser.family,
    max(aws_ecs_task_definition.parser.revision, data.aws_ecs_task_definition.parser.revision),
  )
}

# aws_ecs_service
resource "aws_ecs_service" "app" {
  name                              = "${var.prefix}-app-${var.environment}"
  cluster                           = aws_ecs_cluster.this.arn
  task_definition                   = local.latest_task_definition_app
  desired_count                     = var.app.desired_count
  launch_type                       = "FARGATE"
  platform_version                  = "1.4.0"
  health_check_grace_period_seconds = 60
  propagate_tags                    = "SERVICE"

  network_configuration {
    assign_public_ip = true
    security_groups  = [var.app.security_group_id]
    subnets          = var.app.subnet_ids
  }

  load_balancer {
    target_group_arn = var.app.target_group_arn
    container_name   = "${var.prefix}-app"
    container_port   = 3000
  }

  tags = {
    Environment = var.environment
  }
}

resource "aws_ecs_service" "worker" {
  name             = "${var.prefix}-worker-${var.environment}"
  cluster          = aws_ecs_cluster.this.arn
  task_definition  = local.latest_task_definition_worker
  desired_count    = var.worker.desired_count
  launch_type      = "FARGATE"
  platform_version = "1.4.0"
  propagate_tags   = "SERVICE"

  # Fargateに置き換え
  # capacity_provider_strategy {
  #   capacity_provider = aws_ecs_capacity_provider.worker.name
  #   base              = 0
  #   weight            = 1
  # }

  network_configuration {
    assign_public_ip = false
    security_groups  = [var.worker.security_group_id]
    subnets          = var.worker.subnet_ids
  }

  tags = {
    Environment = var.environment
  }
}

resource "aws_ecs_service" "ssm" {
  name             = "${var.prefix}-ssm-${var.environment}"
  cluster          = aws_ecs_cluster.this.arn
  task_definition  = aws_ecs_task_definition.ssm.arn
  desired_count    = var.ssm.desired_count
  launch_type      = "FARGATE"
  platform_version = "1.4.0"
  propagate_tags   = "SERVICE"

  network_configuration {
    assign_public_ip = false
    security_groups  = [var.worker.security_group_id]
    subnets          = var.worker.subnet_ids
  }

  tags = {
    Environment = var.environment
  }
}

resource "aws_ecs_service" "parser" {
  name             = "${var.prefix}-parser-${var.environment}"
  cluster          = aws_ecs_cluster.this.arn
  task_definition  = local.latest_task_definition_parser
  desired_count    = var.parser.desired_count
  launch_type      = "FARGATE"
  platform_version = "1.4.0"
  propagate_tags   = "SERVICE"

  network_configuration {
    assign_public_ip = false
    security_groups  = [var.parser.security_group_id]
    subnets          = var.parser.subnet_ids
  }

  load_balancer {
    target_group_arn = var.parser.target_group_arn
    container_name   = "${var.prefix}-parser"
    container_port   = 3000
  }

  tags = {
    Environment = var.environment
  }
}
