# aws_backup_plan
resource "aws_backup_plan" "this" {
  name = "${var.prefix}-${var.environment}"

  rule {
    rule_name         = "DailyBackups"
    target_vault_name = aws_backup_vault.this.name
    schedule          = "cron(0 20 * * ? *)"
    start_window      = 60
    completion_window = 180
    lifecycle {
      cold_storage_after = 0
      delete_after       = 30
    }
    recovery_point_tags = {
      Environment = var.environment
    }
  }

  tags = {
    Environment = var.environment
  }
}
