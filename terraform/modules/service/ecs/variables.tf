variable "environment" {}

variable "prefix" {}

variable "domain_name" {}

variable "account_id" {}

variable "aws_region" {}

variable "vpc_id" {}

variable "execution_role_arn" {}

variable "schedule_role_arn" {}

variable "resource_s3_bucket" {}

variable "query_parser_parsed_uri" {}

variable "aws_sqs_queue_name" {}

variable "aws_secretsmanager_secret" {}

variable "redis_url" {}

# Fargateに置き換え
# variable "auto_scaling_group_arn" {}

variable "app" {
  type = object({
    desired_count     = number
    security_group_id = string
    subnet_ids        = list(string)
    target_group_arn  = string
    cpu               = number
    memory            = number
    task_role_arn     = string
    image             = string
    awslogs_group     = string
  })
}

variable "worker" {
  type = object({
    desired_count     = number
    security_group_id = string
    subnet_ids        = list(string)
    cpu               = number
    memory            = number
    task_role_arn     = string
    image             = string
    awslogs_group     = string
    efs_id            = string
  })
}

variable "ssm" {
  type = object({
    desired_count     = number
    security_group_id = string
    subnet_ids        = list(string)
    cpu               = number
    memory            = number
    task_role_arn     = string
    image             = string
    awslogs_group     = string
    efs_id            = string
  })
}

variable "parser" {
  type = object({
    desired_count     = number
    security_group_id = string
    subnet_ids        = list(string)
    target_group_arn  = string
    cpu               = number
    memory            = number
    image             = string
    awslogs_group     = string
  })
}

variable "transfer" {
  type = object({
    security_group_id = string
    subnet_ids        = list(string)
    cpu               = number
    memory            = number
    image             = string
    awslogs_group     = string
    efs_id            = string
  })
}

variable "app_migration" {
  type = object({
    cpu           = number
    memory        = number
    task_role_arn = string
    image         = string
    awslogs_group = string
  })
}

variable "app_seed" {
  type = object({
    cpu           = number
    memory        = number
    task_role_arn = string
    image         = string
    awslogs_group = string
  })
}

variable "cron_synchronize_metastore_daily_job" {
  type = object({
    security_group_id = string
    subnet_ids        = list(string)
    cpu               = number
    memory            = number
    task_role_arn     = string
    image             = string
    awslogs_group     = string
  })
}

variable "cron_enqueue_scheduled_workflow_job" {
  type = object({
    security_group_id = string
    subnet_ids        = list(string)
    cpu               = number
    memory            = number
    task_role_arn     = string
    image             = string
    awslogs_group     = string
  })
}

variable "cron_recover_query_operation_job" {
  type = object({
    security_group_id = string
    subnet_ids        = list(string)
    cpu               = number
    memory            = number
    task_role_arn     = string
    image             = string
    awslogs_group     = string
  })
}
