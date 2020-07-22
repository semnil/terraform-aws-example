# aws_iam_role_policy
resource "aws_iam_role_policy" "wp" {
  name = "${var.prefix}-wp-${var.environment}"
  role = aws_iam_role.wp.id
  policy = templatefile("${path.module}/aws_iam_role_policies/wp.json.tpl",
    {
      website_s3_bucket = var.website_s3_bucket
    }
  )
}
