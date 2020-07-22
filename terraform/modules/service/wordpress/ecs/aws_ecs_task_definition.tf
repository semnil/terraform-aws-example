resource "aws_ecs_task_definition" "wp" {
  family                   = "${var.prefix}-wp-${var.environment}"
  cpu                      = var.task_config.cpu
  memory                   = var.task_config.memory
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  task_role_arn            = var.task_config.task_role_arn
  execution_role_arn       = var.execution_role_arn

  container_definitions = templatefile("${path.module}/aws_ecs_task_definitions/wp.json.tpl",
    {
      image             = var.task_config.image
      prefix            = var.prefix
      aws_region        = var.aws_region
      awslogs_group     = var.task_config.awslogs_group
      mnt_path_shared   = "/var/www/html"
      mnt_volume_shared = "efs"
      db_database       = var.database.database_name
      db_username       = var.database.master_username
      db_password       = var.database.master_password
      db_endpoint       = join(":", [var.database.endpoint, var.database.port])
    }
  )

  volume {
    name = "efs"

    efs_volume_configuration {
      file_system_id = var.task_config.efs_id
      root_directory = "/"
    }
  }

  tags = {
    Environment = var.environment
  }
}
