resource "aws_iam_policy" "send_sqs" {
  name = "${var.prefix}-send-sqs-${var.environment}"
  policy = templatefile("${path.module}/aws_iam_policies/send_sqs.json.tpl",
    {
      account_id  = var.aws_account_id
      aws_region  = var.aws_region
      environment = var.environment
      prefix      = var.prefix
    }
  )
}

resource "aws_iam_policy" "send_firehose" {
  name = "${var.prefix}-send-firehose-${var.environment}"
  policy = templatefile("${path.module}/aws_iam_policies/send_firehose.json.tpl",
    {
      account_id  = var.aws_account_id
      aws_region  = var.aws_region
      environment = var.environment
      prefix      = var.prefix
    }
  )
}
