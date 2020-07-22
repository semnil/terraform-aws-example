# aws_cloudwatch_log_group
resource "aws_cloudwatch_log_group" "vpn" {
  name              = "/vpn/${var.prefix}/${var.environment}"
  retention_in_days = 180

  tags = {
    Environment = var.environment
  }
}

# aws_cloudwatch_log_stream
resource "aws_cloudwatch_log_stream" "vpn" {
  name           = "VPNStream"
  log_group_name = aws_cloudwatch_log_group.vpn.name
}
