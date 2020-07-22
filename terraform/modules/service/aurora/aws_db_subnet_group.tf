# aws_db_subnet_group
resource "aws_db_subnet_group" "this" {
  name       = "${var.prefix}-${var.environment}"
  subnet_ids = var.subnet_ids

  tags = {
    Environment = var.environment
  }
}
