output "database_url_writer" {
  value = "postgresql://${local.db_username}:${local.db_password}@${aws_rds_cluster.this.endpoint}/${local.db_database}"
}

output "database_url_reader" {
  value = "postgresql://${local.db_username}:${local.db_password}@${aws_rds_cluster.this.reader_endpoint}/${local.db_database}"
}

output "rds_cluster" {
  value = {
    this = aws_rds_cluster.this
  }
}

output "db_subnet_group" {
  value = {
    this = aws_db_subnet_group.this
  }
}
