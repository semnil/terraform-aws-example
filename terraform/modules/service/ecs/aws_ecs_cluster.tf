# aws_ecs_cluster
resource "aws_ecs_cluster" "this" {
  name = "${var.prefix}-${var.environment}"

  capacity_providers = [
    "FARGATE",
    "FARGATE_SPOT",
    # Fargateに置き換え
    # aws_ecs_capacity_provider.worker.name,
  ]

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = {
    Environment = var.environment
  }
}
