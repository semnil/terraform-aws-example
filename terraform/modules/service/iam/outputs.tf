output "iam_role" {
  value = {
    ecs_task_execution  = aws_iam_role.ecs_task_execution
    app                 = aws_iam_role.app
    worker              = aws_iam_role.worker
    ssm                 = aws_iam_role.ssm
    cron                = aws_iam_role.cron
    schedule            = aws_iam_role.schedule
    codepipeline        = aws_iam_role.codepipeline
    events_codepipeline = aws_iam_role.events_codepipeline
    rds_monitoring      = aws_iam_role.rds_monitoring
    firehose            = aws_iam_role.firehose
  }
}
