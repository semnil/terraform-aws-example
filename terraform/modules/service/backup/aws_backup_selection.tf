# aws_backup_selection
resource "aws_backup_selection" "this" {
  iam_role_arn = "arn:aws:iam::${var.aws_account_id}:role/service-role/AWSBackupDefaultServiceRole"
  name         = "${var.prefix}-${var.environment}"
  plan_id      = aws_backup_plan.this.id

  selection_tag {
    type  = "STRINGEQUALS"
    key   = "BackupPlan"
    value = "${var.prefix}-${var.environment}"
  }
}
