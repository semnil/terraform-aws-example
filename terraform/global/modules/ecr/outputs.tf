output "ecr_repository" {
  value = {
    app      = aws_ecr_repository.app
    parser   = aws_ecr_repository.parser
    transfer = aws_ecr_repository.transfer
  }
}
