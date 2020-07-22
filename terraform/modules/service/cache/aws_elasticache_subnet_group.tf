# aws_elasticache_subnet_group
resource "aws_elasticache_subnet_group" "this" {
  name       = "${var.prefix}-${var.environment}"
  subnet_ids = var.subnet_ids
}
