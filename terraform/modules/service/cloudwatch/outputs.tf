output "cloudwatch_log_group" {
  value = {
    app      = aws_cloudwatch_log_group.app
    worker   = aws_cloudwatch_log_group.worker
    ssm      = aws_cloudwatch_log_group.ssm
    cron     = aws_cloudwatch_log_group.cron
    parser   = aws_cloudwatch_log_group.parser
    transfer = aws_cloudwatch_log_group.transfer
    audit    = aws_cloudwatch_log_group.audit
  }
}
