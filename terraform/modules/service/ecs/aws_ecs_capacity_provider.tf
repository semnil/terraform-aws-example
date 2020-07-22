# aws_ecs_capacity_provider
# Fargateに置き換え
# resource "aws_ecs_capacity_provider" "worker" {
#   name = "${var.prefix}-worker-${var.environment}"
#
#   auto_scaling_group_provider {
#     auto_scaling_group_arn         = var.auto_scaling_group_arn
#     managed_termination_protection = "DISABLED"
#
#     managed_scaling {
#       status          = "ENABLED"
#       target_capacity = 100
#     }
#   }
#
#   tags = {
#     Environment = var.environment
#   }
# }
