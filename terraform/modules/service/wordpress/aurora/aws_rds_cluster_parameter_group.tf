# aws_rds_cluster_parameter_group
resource "aws_rds_cluster_parameter_group" "wp" {
  name        = "${var.prefix}-wp-mysql5-6-${var.environment}"
  family      = "aurora5.6"
  description = "Cluster parameter group for ${var.prefix} ${title(var.environment)}"

  parameter {
    name         = "time_zone"
    value        = "Asia/Tokyo"
    apply_method = "immediate"
  }

  tags = {
    Environment = var.environment
  }
}
