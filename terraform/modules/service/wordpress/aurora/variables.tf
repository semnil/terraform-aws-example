variable "environment" {}

variable "prefix" {}

variable "db_subnet_group_name" {}

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
  })
}
