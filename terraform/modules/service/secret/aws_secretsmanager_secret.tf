resource "aws_secretsmanager_secret" "app" {
  name        = "${var.prefix}-app-${var.environment}"
  description = "${var.prefix} ${title(var.environment)} アプリケーションパラメータ"

  tags = {
    Environment = var.environment
  }
}
