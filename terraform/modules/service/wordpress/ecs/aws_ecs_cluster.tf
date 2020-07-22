# aws_ecs_cluster
resource "aws_ecs_cluster" "wp" {
  name = "${var.prefix}-wp-${var.environment}"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = {
    Environment = var.environment
  }
}
