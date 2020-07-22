# aws_backup_vault
resource "aws_backup_vault" "this" {
  name = "${var.prefix}-${var.environment}"

  tags = {
    Environment = var.environment
  }
}
