output "secretsmanager_secret" {
  value = {
    app = aws_secretsmanager_secret.app
  }
}
