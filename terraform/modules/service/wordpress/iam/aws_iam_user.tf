# aws_iam_user
resource "aws_iam_user" "wp_plugins" {
  name = "${var.prefix}-wp-plugins-${var.environment}"
}
