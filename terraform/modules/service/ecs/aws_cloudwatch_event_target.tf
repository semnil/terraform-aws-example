resource "aws_cloudwatch_event_target" "cron_synchronize_metastore_daily_job" {
  target_id = "${var.prefix}-cron-synchronize-metastore-daily-job-${var.environment}"
  rule      = aws_cloudwatch_event_rule.cron_synchronize_metastore_daily_job.name
  role_arn  = var.schedule_role_arn
  arn       = aws_ecs_cluster.this.arn

  ecs_target {
    launch_type         = "FARGATE"
    task_count          = 1
    platform_version    = "1.4.0"
    task_definition_arn = aws_ecs_task_definition.cron_synchronize_metastore_daily_job.arn

    network_configuration {
      assign_public_ip = "false"
      security_groups  = [var.cron_synchronize_metastore_daily_job.security_group_id]
      subnets          = var.cron_synchronize_metastore_daily_job.subnet_ids
    }
  }
}

resource "aws_cloudwatch_event_target" "cron_enqueue_scheduled_workflow_job" {
  target_id = "${var.prefix}-cron-enqueue-scheduled-workflow-job-${var.environment}"
  rule      = aws_cloudwatch_event_rule.cron_enqueue_scheduled_workflow_job.name
  role_arn  = var.schedule_role_arn
  arn       = aws_ecs_cluster.this.arn

  ecs_target {
    launch_type         = "FARGATE"
    task_count          = 1
    platform_version    = "1.4.0"
    task_definition_arn = aws_ecs_task_definition.cron_enqueue_scheduled_workflow_job.arn

    network_configuration {
      assign_public_ip = "false"
      security_groups  = [var.cron_enqueue_scheduled_workflow_job.security_group_id]
      subnets          = var.cron_enqueue_scheduled_workflow_job.subnet_ids
    }
  }
}

resource "aws_cloudwatch_event_target" "cron_recover_query_operation_job" {
  target_id = "${var.prefix}-cron-recover-query-operation-job-${var.environment}"
  rule      = aws_cloudwatch_event_rule.cron_recover_query_operation_job.name
  role_arn  = var.schedule_role_arn
  arn       = aws_ecs_cluster.this.arn

  ecs_target {
    launch_type         = "FARGATE"
    task_count          = 1
    platform_version    = "1.4.0"
    task_definition_arn = aws_ecs_task_definition.cron_recover_query_operation_job.arn

    network_configuration {
      assign_public_ip = "false"
      security_groups  = [var.cron_recover_query_operation_job.security_group_id]
      subnets          = var.cron_recover_query_operation_job.subnet_ids
    }
  }
}
