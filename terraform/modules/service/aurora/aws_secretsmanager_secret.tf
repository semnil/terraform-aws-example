resource "aws_secretsmanager_secret" "db" {
  name                    = "${var.prefix}-db-${var.environment}"
  description             = "${var.prefix} ${title(var.environment)} データベース情報"
  recovery_window_in_days = 0

  tags = {
    Environment = var.environment
  }
}

resource "aws_secretsmanager_secret_version" "db" {
  secret_id = aws_secretsmanager_secret.db.id
  secret_string = jsonencode(
    {
      username            = aws_rds_cluster.this.master_username
      password            = aws_rds_cluster.this.master_password
      engine              = aws_rds_cluster.this.engine
      host                = aws_rds_cluster.this.endpoint
      port                = aws_rds_cluster.this.port
      dbname              = aws_rds_cluster.this.database_name
      dbClusterIdentifier = aws_rds_cluster.this.cluster_identifier
    }
  )
}
