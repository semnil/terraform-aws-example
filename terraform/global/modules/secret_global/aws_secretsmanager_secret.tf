resource "aws_secretsmanager_secret" "slack_token" {
  name                    = "${var.prefix}-slack-token"
  description             = "Slack App Verification Token"
  recovery_window_in_days = 0

  tags = {
    Environment = var.environment
  }
}

resource "aws_secretsmanager_secret" "slack_oauth_token" {
  name                    = "${var.prefix}-slack-oauth-token"
  description             = "Slack App OAuth Access Token"
  recovery_window_in_days = 0

  tags = {
    Environment = var.environment
  }
}
