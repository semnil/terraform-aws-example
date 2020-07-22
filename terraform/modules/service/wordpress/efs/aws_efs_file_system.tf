# aws_efs_file_system
resource "aws_efs_file_system" "wp_shared" {
  creation_token = "${var.prefix}-wp-shared-${var.environment}"

  tags = {
    Name        = "${var.prefix}-wp-shared-${var.environment}"
    Environment = var.environment
    BackupPlan  = "${var.prefix}-${var.environment}"
  }
}
