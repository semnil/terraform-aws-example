# aws_elasticache_replication_group
resource "aws_elasticache_replication_group" "this" {
  replication_group_id          = "${var.prefix}-${var.environment}"
  replication_group_description = "Cluster Disabled"
  engine                        = "redis"
  engine_version                = var.cluster_settings.engine_version
  number_cache_clusters         = var.cluster_settings.number_cache_clusters
  node_type                     = var.cluster_settings.node_type
  snapshot_window               = var.cluster_settings.snapshot_window
  snapshot_retention_limit      = var.cluster_settings.snapshot_retention_limit
  maintenance_window            = var.cluster_settings.maintenance_window
  automatic_failover_enabled    = true
  port                          = var.cluster_settings.port
  apply_immediately             = false
  security_group_ids            = var.cluster_settings.security_group_ids
  parameter_group_name          = aws_elasticache_parameter_group.this.name
  subnet_group_name             = aws_elasticache_subnet_group.this.name

  tags = {
    Environment = var.environment
  }
}
