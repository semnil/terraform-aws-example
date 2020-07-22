output "rds_cluster" {
  value = {
    wp = aws_rds_cluster.wp
  }
}
