resource "aws_secretsmanager_secret" "db_wp" {
  name                    = "${var.prefix}-db-wp-${var.environment}"
  description             = "Wordpress ${title(var.environment)} データベース情報"
  recovery_window_in_days = 0

  tags = {
    Environment = var.environment
  }
}

resource "aws_secretsmanager_secret_version" "db_wp" {
  secret_id = aws_secretsmanager_secret.db_wp.id
  secret_string = jsonencode(
    {
      username            = aws_rds_cluster.wp.master_username
      password            = aws_rds_cluster.wp.master_password
      engine              = aws_rds_cluster.wp.engine
      host                = aws_rds_cluster.wp.endpoint
      port                = aws_rds_cluster.wp.port
      dbname              = aws_rds_cluster.wp.database_name
      dbClusterIdentifier = aws_rds_cluster.wp.cluster_identifier
    }
  )
}
