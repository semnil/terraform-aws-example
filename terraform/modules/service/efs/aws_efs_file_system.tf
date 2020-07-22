# aws_efs_file_system
resource "aws_efs_file_system" "shared" {
  creation_token = "${var.prefix}-worker-shared-${var.environment}"

  tags = {
    Name        = "${var.prefix}-worker-shared-${var.environment}"
    Environment = var.environment
  }
}
