# aws_sns_topic
resource "aws_sns_topic" "chatbot" {
  name = "${var.prefix}-chatbot-alert-${var.environment}"

  tags = {
    Environment = var.environment
  }
}

# CodePipeline通知の権限追加
resource "aws_sns_topic_policy" "chatbot" {
  arn    = aws_sns_topic.chatbot.arn
  policy = data.aws_iam_policy_document.sns_chatbot.json
}

data "aws_iam_policy_document" "sns_chatbot" {
  source_json = aws_sns_topic.chatbot.policy

  statement {
    sid    = "CodeStarNotifications"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["codestar-notifications.amazonaws.com"]
    }

    actions = [
      "SNS:Publish",
    ]

    resources = [
      aws_sns_topic.chatbot.arn,
    ]
  }
}
