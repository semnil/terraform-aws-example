output "secretsmanager_secret" {
  value = {
    wp_plugins = aws_secretsmanager_secret.wp_plugins
  }
}
