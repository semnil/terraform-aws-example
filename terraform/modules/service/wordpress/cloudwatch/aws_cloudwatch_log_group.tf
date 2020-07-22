# aws_cloudwatch_log_group
resource "aws_cloudwatch_log_group" "wp" {
  name              = "/ecs/${var.prefix}/${var.environment}/wp"
  retention_in_days = 180

  tags = {
    Environment = var.environment
  }
}
