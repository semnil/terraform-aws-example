# aws_cloudwatch_log_group
resource "aws_cloudwatch_log_group" "app" {
  name              = "/ecs/${var.prefix}/${var.environment}/app"
  retention_in_days = 180

  tags = {
    Environment = var.environment
  }
}

resource "aws_cloudwatch_log_group" "worker" {
  name              = "/ecs/${var.prefix}/${var.environment}/worker"
  retention_in_days = 180

  tags = {
    Environment = var.environment
  }
}

resource "aws_cloudwatch_log_group" "ssm" {
  name              = "/ecs/${var.prefix}/${var.environment}/ssm"
  retention_in_days = 180

  tags = {
    Environment = var.environment
  }
}

resource "aws_cloudwatch_log_group" "cron" {
  name              = "/ecs/${var.prefix}/${var.environment}/cron"
  retention_in_days = 180

  tags = {
    Environment = var.environment
  }
}

resource "aws_cloudwatch_log_group" "parser" {
  name              = "/ecs/${var.prefix}/${var.environment}/parser"
  retention_in_days = 180

  tags = {
    Environment = var.environment
  }
}

resource "aws_cloudwatch_log_group" "transfer" {
  name              = "/ecs/${var.prefix}/${var.environment}/transfer"
  retention_in_days = 180

  tags = {
    Environment = var.environment
  }
}

resource "aws_cloudwatch_log_group" "audit" {
  name              = "/kinesisfirehose/${var.prefix}/${var.environment}/audit"
  retention_in_days = 180

  tags = {
    Environment = var.environment
  }
}
