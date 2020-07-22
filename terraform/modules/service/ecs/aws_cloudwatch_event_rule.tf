resource "aws_cloudwatch_event_rule" "cron_synchronize_metastore_daily_job" {
  name                = "${var.prefix}-cron-synchronize-metastore-daily-job-${var.environment}"
  schedule_expression = "cron(0 15 * * ? *)"
}

resource "aws_cloudwatch_event_rule" "cron_enqueue_scheduled_workflow_job" {
  name                = "${var.prefix}-cron-enqueue-scheduled-workflow-job-${var.environment}"
  schedule_expression = "cron(0 * * * ? *)"
}

resource "aws_cloudwatch_event_rule" "cron_recover_query_operation_job" {
  name                = "${var.prefix}-cron-recover-query-operation-job-${var.environment}"
  schedule_expression = "cron(*/15 * * * ? *)"
}
