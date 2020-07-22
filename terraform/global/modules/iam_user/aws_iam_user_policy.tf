resource "aws_iam_user_policy" "circleci" {
  name = "${var.prefix}-circleci"
  user = aws_iam_user.circleci.name

  policy = templatefile("${path.module}/aws_iam_policies/ecr_push_pull.json.tpl",
    {
      aws_account_id = var.aws_account_id
      aws_region     = var.aws_region
    }
  )
}
