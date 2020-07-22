# aws_db_parameter_group
resource "aws_db_parameter_group" "this" {
  name        = "${var.prefix}-aurora-postgresql10-${var.environment}"
  family      = "aurora-postgresql10"
  description = "Instance parameter group for ${var.prefix} ${title(var.environment)}"

  tags = {
    Environment = var.environment
  }
}
