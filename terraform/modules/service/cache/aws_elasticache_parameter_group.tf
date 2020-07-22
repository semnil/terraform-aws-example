# Cache
resource "aws_elasticache_parameter_group" "this" {
  name   = "${var.prefix}-${var.environment}"
  family = "redis5.0"

  parameter {
    name  = "cluster-enabled"
    value = "no"
  }
}
