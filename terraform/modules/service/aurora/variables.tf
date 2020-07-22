variable "environment" {}

variable "prefix" {}

variable "subnet_ids" {}

variable "cluster_settings" {
  type = object({
    engine_version               = string
    backup_retention_period      = number
    preferred_backup_window      = string
    preferred_maintenance_window = string
    port                         = number
    vpc_security_group_ids       = list(string)
    kms_key_id                   = string
    skip_final_snapshot          = bool
    deletion_protection          = bool
    number_db_clusters           = number
  })
}

variable "instance_settings" {
  type = object({
    instance_class      = string
    monitoring_role_arn = string
    monitoring_interval = number
  })
}
