resource "aws_iam_role" "ecs_task_execution" {
  name               = "${var.prefix}-ecs-task-execution-${var.environment}"
  path               = "/"
  assume_role_policy = file("${path.module}/aws_iam_policies/ecs_tasks_assume_role_policy.json")
}

resource "aws_iam_role" "app" {
  name               = "${var.prefix}-app-${var.environment}"
  path               = "/"
  assume_role_policy = file("${path.module}/aws_iam_policies/ecs_tasks_assume_role_policy.json")
}

resource "aws_iam_role" "worker" {
  name               = "${var.prefix}-worker-${var.environment}"
  path               = "/"
  assume_role_policy = file("${path.module}/aws_iam_policies/ecs_tasks_assume_role_policy.json")
}

resource "aws_iam_role" "ssm" {
  name               = "${var.prefix}-ssm-${var.environment}"
  path               = "/"
  assume_role_policy = file("${path.module}/aws_iam_policies/sms_ecs_tasks_assume_role_policy.json")
}

resource "aws_iam_role" "cron" {
  name               = "${var.prefix}-cron-${var.environment}"
  path               = "/"
  assume_role_policy = file("${path.module}/aws_iam_policies/ecs_tasks_assume_role_policy.json")
}

resource "aws_iam_role" "schedule" {
  name               = "${var.prefix}-schedule-${var.environment}"
  path               = "/"
  assume_role_policy = file("${path.module}/aws_iam_policies/events_assume_role_policy.json")
}

resource "aws_iam_role" "rds_monitoring" {
  name               = "${var.prefix}-rds-monitoring-${var.environment}"
  path               = "/"
  assume_role_policy = file("${path.module}/aws_iam_policies/monitoring_rds_assume_role_policy.json")
}

resource "aws_iam_role" "firehose" {
  name               = "${var.prefix}-firehose-${var.environment}"
  path               = "/"
  assume_role_policy = file("${path.module}/aws_iam_policies/firehose_assume_role_policy.json")
}

resource "aws_iam_role" "codepipeline" {
  name               = "${var.prefix}-codepipeline-${var.environment}"
  path               = "/"
  assume_role_policy = file("${path.module}/aws_iam_policies/codepipeline_assume_role_policy.json")
}

resource "aws_iam_role" "events_codepipeline" {
  name               = "${var.prefix}-events-codepipeline-${var.environment}"
  path               = "/"
  assume_role_policy = file("${path.module}/aws_iam_policies/events_assume_role_policy.json")
}
