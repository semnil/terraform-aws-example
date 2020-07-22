resource "random_string" "password" {
  length      = 32
  special     = false
  min_upper   = 1
  min_lower   = 1
  min_numeric = 1
}

locals {
  db_database = "wordpress"
  db_username = "wordpress"
  db_password = random_string.password.result
}

# aws_rds_cluster
resource "aws_rds_cluster" "wp" {
  cluster_identifier              = "${var.prefix}-wp-${var.environment}"
  engine                          = "aurora"
  engine_version                  = var.cluster_settings.engine_version
  engine_mode                     = "serverless"
  database_name                   = local.db_database
  master_username                 = local.db_username
  master_password                 = local.db_password
  backup_retention_period         = var.cluster_settings.backup_retention_period
  preferred_backup_window         = var.cluster_settings.preferred_backup_window
  preferred_maintenance_window    = var.cluster_settings.preferred_maintenance_window
  port                            = var.cluster_settings.port
  apply_immediately               = false
  vpc_security_group_ids          = var.cluster_settings.vpc_security_group_ids
  db_subnet_group_name            = var.db_subnet_group_name
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.wp.name
  storage_encrypted               = true
  kms_key_id                      = var.cluster_settings.kms_key_id
  copy_tags_to_snapshot           = true
  backtrack_window                = 0

  skip_final_snapshot = var.cluster_settings.skip_final_snapshot
  deletion_protection = var.cluster_settings.deletion_protection

  scaling_configuration {
    auto_pause               = true
    max_capacity             = 2
    min_capacity             = 1
    seconds_until_auto_pause = 300
    timeout_action           = "ForceApplyCapacityChange"
  }

  lifecycle {
    ignore_changes = [master_password]
  }

  tags = {
    Environment = var.environment
  }
}
