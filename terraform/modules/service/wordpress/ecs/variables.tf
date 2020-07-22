variable "environment" {}

variable "prefix" {}

variable "domain_name" {}

variable "aws_region" {}

variable "execution_role_arn" {}

variable "database" {}

variable "task_config" {
  type = object({
    desired_count     = number
    cpu               = number
    memory            = number
    subnet_ids        = list(string)
    security_group_id = string
    target_group_arn  = string
    task_role_arn     = string
    image             = string
    awslogs_group     = string
    efs_id            = string
  })
}
