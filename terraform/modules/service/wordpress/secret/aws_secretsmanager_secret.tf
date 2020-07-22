resource "aws_secretsmanager_secret" "wp_plugins" {
  name        = "iam-user-${var.prefix}-wp-plugins-${var.environment}"
  description = "Wordpressのプラグインで使用するIAMUserの認証キー（保管用）"

  tags = {
    Environment = var.environment
  }
}
