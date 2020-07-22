resource "aws_ecs_task_definition" "app" {
  family                   = "${var.prefix}-app-${var.environment}"
  cpu                      = var.app.cpu
  memory                   = var.app.memory
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  task_role_arn            = var.app.task_role_arn
  execution_role_arn       = var.execution_role_arn

  container_definitions = templatefile("${path.module}/aws_ecs_task_definitions/app.json.tpl",
    {
      image                         = var.app.image
      prefix                        = var.prefix
      account_id                    = var.account_id
      aws_region                    = var.aws_region
      environment                   = var.environment
      awslogs_group                 = var.app.awslogs_group
      s3_bucket                     = var.resource_s3_bucket
      query_parser_parsed_uri       = var.query_parser_parsed_uri
      aws_sqs_queue_name            = var.aws_sqs_queue_name
      redis_url                     = var.redis_url
      oauth2_login_host             = "auth.${var.domain_name}"
      default_domain                = var.domain_name
      aws_secretsmanager_secret_arn = var.aws_secretsmanager_secret.app.arn
    }
  )

  tags = {
    Environment = var.environment
  }
}

resource "aws_ecs_task_definition" "app_migration" {
  family                   = "${var.prefix}-app-migration-${var.environment}"
  cpu                      = var.app_migration.cpu
  memory                   = var.app_migration.memory
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  task_role_arn            = var.app_migration.task_role_arn
  execution_role_arn       = var.execution_role_arn

  container_definitions = templatefile("${path.module}/aws_ecs_task_definitions/app_migration.json.tpl",
    {
      image                         = var.app_migration.image
      prefix                        = var.prefix
      account_id                    = var.account_id
      aws_region                    = var.aws_region
      environment                   = var.environment
      awslogs_group                 = var.app_migration.awslogs_group
      aws_secretsmanager_secret_arn = var.aws_secretsmanager_secret.app.arn
    }
  )

  tags = {
    Environment = var.environment
  }
}

resource "aws_ecs_task_definition" "app_seed" {
  family                   = "${var.prefix}-app-seed-${var.environment}"
  cpu                      = var.app_seed.cpu
  memory                   = var.app_seed.memory
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  task_role_arn            = var.app_seed.task_role_arn
  execution_role_arn       = var.execution_role_arn

  container_definitions = templatefile("${path.module}/aws_ecs_task_definitions/app_seed.json.tpl",
    {
      image                         = var.app_seed.image
      prefix                        = var.prefix
      account_id                    = var.account_id
      aws_region                    = var.aws_region
      environment                   = var.environment
      awslogs_group                 = var.app_seed.awslogs_group
      aws_secretsmanager_secret_arn = var.aws_secretsmanager_secret.app.arn
    }
  )

  tags = {
    Environment = var.environment
  }
}

resource "aws_ecs_task_definition" "worker" {
  family                   = "${var.prefix}-worker-${var.environment}"
  cpu                      = var.worker.cpu
  memory                   = var.worker.memory
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  task_role_arn            = var.worker.task_role_arn
  execution_role_arn       = var.execution_role_arn

  container_definitions = templatefile("${path.module}/aws_ecs_task_definitions/worker.json.tpl",
    {
      image                         = var.worker.image
      prefix                        = var.prefix
      account_id                    = var.account_id
      aws_region                    = var.aws_region
      environment                   = var.environment
      awslogs_group                 = var.worker.awslogs_group
      mnt_path_task                 = "/mnt/task"
      mnt_volume_task               = "${var.prefix}-task"
      mnt_path_shared               = "/mnt/shared"
      mnt_volume_shared             = "${var.prefix}-shared"
      s3_bucket                     = var.resource_s3_bucket
      query_parser_parsed_uri       = var.query_parser_parsed_uri
      aws_sqs_queue_name            = var.aws_sqs_queue_name
      aws_secretsmanager_secret_arn = var.aws_secretsmanager_secret.app.arn
      redis_url                     = var.redis_url
    }
  )

  volume {
    name = "${var.prefix}-shared"

    efs_volume_configuration {
      file_system_id = var.worker.efs_id
      root_directory = "/"
    }
  }

  tags = {
    Environment = var.environment
  }
}

resource "aws_ecs_task_definition" "ssm" {
  family                   = "${var.prefix}-ssm-${var.environment}"
  cpu                      = var.ssm.cpu
  memory                   = var.ssm.memory
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  task_role_arn            = var.ssm.task_role_arn
  execution_role_arn       = var.execution_role_arn

  container_definitions = templatefile("${path.module}/aws_ecs_task_definitions/ssm.json.tpl",
    {
      image                         = var.worker.image
      prefix                        = var.prefix
      account_id                    = var.account_id
      aws_region                    = var.aws_region
      environment                   = var.environment
      awslogs_group                 = var.ssm.awslogs_group
      ssm_instance_name             = "${var.prefix}-ssm-${var.environment}"
      ssm_iam_role                  = "${var.prefix}-ssm-${var.environment}"
      mnt_path_task                 = "/mnt/task"
      mnt_volume_task               = "${var.prefix}-task"
      mnt_path_shared               = "/mnt/shared"
      mnt_volume_shared             = "${var.prefix}-shared"
      s3_bucket                     = var.resource_s3_bucket
      query_parser_parsed_uri       = var.query_parser_parsed_uri
      aws_sqs_queue_name            = var.aws_sqs_queue_name
      aws_secretsmanager_secret_arn = var.aws_secretsmanager_secret.app.arn
      redis_url                     = var.redis_url
    }
  )

  volume {
    name = "${var.prefix}-shared"

    efs_volume_configuration {
      file_system_id = var.ssm.efs_id
      root_directory = "/"
    }
  }

  tags = {
    Environment = var.environment
  }
}

resource "aws_ecs_task_definition" "cron_synchronize_metastore_daily_job" {
  family                   = "${var.prefix}-cron-synchronize-metastore-daily-job-${var.environment}"
  cpu                      = var.cron_synchronize_metastore_daily_job.cpu
  memory                   = var.cron_synchronize_metastore_daily_job.memory
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  task_role_arn            = var.cron_synchronize_metastore_daily_job.task_role_arn
  execution_role_arn       = var.execution_role_arn

  container_definitions = templatefile("${path.module}/aws_ecs_task_definitions/cron.json.tpl",
    {
      image                         = var.cron_synchronize_metastore_daily_job.image
      prefix                        = var.prefix
      account_id                    = var.account_id
      aws_region                    = var.aws_region
      environment                   = var.environment
      awslogs_group                 = var.cron_synchronize_metastore_daily_job.awslogs_group
      aws_sqs_queue_name            = var.aws_sqs_queue_name
      aws_secretsmanager_secret_arn = var.aws_secretsmanager_secret.app.arn
      command                       = "[\"bundle\", \"exec\", \"rails\", \"runner\", \"SynchronizeMetastoreDailyJob.perform_now\"]"
    }
  )

  tags = {
    Environment = var.environment
  }
}

resource "aws_ecs_task_definition" "cron_enqueue_scheduled_workflow_job" {
  family                   = "${var.prefix}-cron-enqueue-scheduled-workflow-job-${var.environment}"
  cpu                      = var.cron_enqueue_scheduled_workflow_job.cpu
  memory                   = var.cron_enqueue_scheduled_workflow_job.memory
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  task_role_arn            = var.cron_enqueue_scheduled_workflow_job.task_role_arn
  execution_role_arn       = var.execution_role_arn

  container_definitions = templatefile("${path.module}/aws_ecs_task_definitions/cron.json.tpl",
    {
      image                         = var.cron_enqueue_scheduled_workflow_job.image
      prefix                        = var.prefix
      account_id                    = var.account_id
      aws_region                    = var.aws_region
      environment                   = var.environment
      awslogs_group                 = var.cron_enqueue_scheduled_workflow_job.awslogs_group
      aws_sqs_queue_name            = var.aws_sqs_queue_name
      aws_secretsmanager_secret_arn = var.aws_secretsmanager_secret.app.arn
      command                       = "[\"bundle\", \"exec\", \"rails\", \"runner\", \"EnqueueScheduledWorkflowJob.perform_now\"]"
    }
  )

  tags = {
    Environment = var.environment
  }
}

resource "aws_ecs_task_definition" "cron_recover_query_operation_job" {
  family                   = "${var.prefix}-cron-recover-query-operation-job-${var.environment}"
  cpu                      = var.cron_enqueue_scheduled_workflow_job.cpu
  memory                   = var.cron_enqueue_scheduled_workflow_job.memory
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  task_role_arn            = var.cron_enqueue_scheduled_workflow_job.task_role_arn
  execution_role_arn       = var.execution_role_arn

  container_definitions = templatefile("${path.module}/aws_ecs_task_definitions/cron.json.tpl",
    {
      image                         = var.cron_recover_query_operation_job.image
      prefix                        = var.prefix
      account_id                    = var.account_id
      aws_region                    = var.aws_region
      environment                   = var.environment
      awslogs_group                 = var.cron_recover_query_operation_job.awslogs_group
      aws_sqs_queue_name            = var.aws_sqs_queue_name
      aws_secretsmanager_secret_arn = var.aws_secretsmanager_secret.app.arn
      command                       = "[\"bundle\", \"exec\", \"rails\", \"runner\", \"RecoverQueryOperationJob.perform_now\"]"
    }
  )

  tags = {
    Environment = var.environment
  }
}

resource "aws_ecs_task_definition" "parser" {
  family                   = "${var.prefix}-parser-${var.environment}"
  cpu                      = var.parser.cpu
  memory                   = var.parser.memory
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = var.execution_role_arn

  container_definitions = templatefile("${path.module}/aws_ecs_task_definitions/parser.json.tpl",
    {
      image         = var.parser.image
      prefix        = var.prefix
      account_id    = var.account_id
      aws_region    = var.aws_region
      environment   = var.environment
      awslogs_group = var.parser.awslogs_group
    }
  )

  tags = {
    Environment = var.environment
  }
}

resource "aws_ecs_task_definition" "transfer" {
  family                   = "${var.prefix}-transfer-${var.environment}"
  cpu                      = var.transfer.cpu
  memory                   = var.transfer.memory
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = var.execution_role_arn

  container_definitions = templatefile("${path.module}/aws_ecs_task_definitions/transfer.json.tpl",
    {
      image             = var.transfer.image
      prefix            = var.prefix
      account_id        = var.account_id
      aws_region        = var.aws_region
      environment       = var.environment
      awslogs_group     = var.transfer.awslogs_group
      mnt_path_shared   = "/mnt/shared"
      mnt_volume_shared = "${var.prefix}-shared"
      memory            = var.transfer.memory
    }
  )

  volume {
    name = "${var.prefix}-shared"

    efs_volume_configuration {
      file_system_id = var.transfer.efs_id
      root_directory = "/"
    }
  }

  tags = {
    Environment = var.environment
  }
}
