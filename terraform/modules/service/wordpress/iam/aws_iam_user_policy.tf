# aws_iam_user_policy
resource "aws_iam_user_policy" "wp_plugins" {
  name = "${var.prefix}-wp-plugins-${var.environment}"
  user = aws_iam_user.wp_plugins.name

  policy = templatefile("${path.module}/aws_iam_role_policies/wp.json.tpl",
    {
      website_s3_bucket = var.website_s3_bucket
    }
  )
}
