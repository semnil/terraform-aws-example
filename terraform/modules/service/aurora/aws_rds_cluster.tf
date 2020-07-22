resource "random_string" "password" {
  length      = 32
  special     = false
  min_upper   = 1
  min_lower   = 1
  min_numeric = 1
}

locals {
  db_database = var.prefix
  db_username = "root"
  db_password = random_string.password.result
}

# aws_rds_cluster
resource "aws_rds_cluster" "this" {
  cluster_identifier              = "${var.prefix}-${var.environment}"
  engine                          = "aurora-postgresql"
  engine_version                  = var.cluster_settings.engine_version
  database_name                   = local.db_database
  master_username                 = local.db_username
  master_password                 = local.db_password
  backup_retention_period         = var.cluster_settings.backup_retention_period
  preferred_backup_window         = var.cluster_settings.preferred_backup_window
  preferred_maintenance_window    = var.cluster_settings.preferred_maintenance_window
  port                            = var.cluster_settings.port
  apply_immediately               = false
  vpc_security_group_ids          = var.cluster_settings.vpc_security_group_ids
  db_subnet_group_name            = aws_db_subnet_group.this.name
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.this.name
  storage_encrypted               = true
  kms_key_id                      = var.cluster_settings.kms_key_id
  copy_tags_to_snapshot           = true
  enabled_cloudwatch_logs_exports = ["postgresql"]

  skip_final_snapshot = var.cluster_settings.skip_final_snapshot
  deletion_protection = var.cluster_settings.deletion_protection

  lifecycle {
    ignore_changes = [
      master_password,
      engine_version,
    ]
  }

  tags = {
    Environment = var.environment
  }
}

# aws_rds_cluster_instance
resource "aws_rds_cluster_instance" "this" {
  count = var.cluster_settings.number_db_clusters

  identifier              = "${var.prefix}-db${count.index}-${var.environment}"
  cluster_identifier      = aws_rds_cluster.this.id
  engine                  = aws_rds_cluster.this.engine
  instance_class          = var.instance_settings.instance_class
  db_subnet_group_name    = aws_db_subnet_group.this.name
  db_parameter_group_name = aws_db_parameter_group.this.name
  monitoring_role_arn     = var.instance_settings.monitoring_role_arn
  monitoring_interval     = var.instance_settings.monitoring_interval

  auto_minor_version_upgrade = false

  tags = {
    Environment = var.environment
  }
}
