# ecs_task_execution
resource "aws_iam_role_policy" "ecs_task_execution" {
  name = "${var.prefix}-ecs-task-execution-${var.environment}"
  role = aws_iam_role.ecs_task_execution.id
  policy = templatefile("${path.module}/aws_iam_role_policies/ecs_task_execution.json.tpl",
    {
      account_id  = var.aws_account_id
      aws_region  = var.aws_region
      environment = var.environment
      prefix      = var.prefix
    }
  )
}

# app
resource "aws_iam_role_policy" "app" {
  name = "${var.prefix}-app-${var.environment}"
  role = aws_iam_role.app.id
  policy = templatefile("${path.module}/aws_iam_role_policies/app.json.tpl",
    {
      account_id  = var.aws_account_id
      aws_region  = var.aws_region
      environment = var.environment
      prefix      = var.prefix
    }
  )
}

# worker
resource "aws_iam_role_policy" "worker" {
  name = "${var.prefix}-worker-${var.environment}"
  role = aws_iam_role.worker.id
  policy = templatefile("${path.module}/aws_iam_role_policies/worker.json.tpl",
    {
      account_id  = var.aws_account_id
      aws_region  = var.aws_region
      environment = var.environment
      prefix      = var.prefix
    }
  )
}

# ssm
resource "aws_iam_role_policy" "ssm" {
  name = "${var.prefix}-ssm-${var.environment}"
  role = aws_iam_role.ssm.id
  policy = templatefile("${path.module}/aws_iam_role_policies/ssm.json.tpl",
    {
      account_id  = var.aws_account_id
      aws_region  = var.aws_region
      environment = var.environment
      prefix      = var.prefix
    }
  )
}

# firehose
resource "aws_iam_role_policy" "firehose" {
  name = aws_iam_role.firehose.name
  role = aws_iam_role.firehose.name
  policy = templatefile("${path.module}/aws_iam_role_policies/firehose_s3.json.tpl",
    {
      s3_bucket     = var.s3_bucket_audit
      log_group_arn = var.audit_log_group_arn
      kms_key_arn   = var.kms_key_firehose
      prefix        = var.prefix
    }
  )
}

# codepipeline
resource "aws_iam_role_policy" "codepipeline" {
  name = "codepipeline-base-policy"
  role = aws_iam_role.codepipeline.name
  policy = templatefile("${path.module}/aws_iam_role_policies/codepipeline.json.tpl",
    {
      kms_codepipeline = var.kms_key_codepipeline
      prefix           = var.prefix
    }
  )
}

# events_codepipeline
resource "aws_iam_role_policy" "events_codepipeline" {
  name = "start-pipeline-execution"
  role = aws_iam_role.events_codepipeline.name
  policy = templatefile("${path.module}/aws_iam_role_policies/events_codepipeline.json.tpl",
    {
      account_id  = var.aws_account_id
      aws_region  = var.aws_region
      environment = var.environment
      prefix      = var.prefix
    }
  )
}
