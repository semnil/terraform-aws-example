resource "aws_ecr_lifecycle_policy" "app" {
  repository = aws_ecr_repository.app.name
  policy     = file("${path.module}/aws_ecr_repository_policies/app.json")
}

resource "aws_ecr_lifecycle_policy" "parser" {
  repository = aws_ecr_repository.parser.name
  policy     = file("${path.module}/aws_ecr_repository_policies/parser.json")
}

resource "aws_ecr_lifecycle_policy" "transfer" {
  repository = aws_ecr_repository.transfer.name
  policy     = file("${path.module}/aws_ecr_repository_policies/transfer.json")
}

resource "aws_ecr_lifecycle_policy" "app_cache" {
  repository = aws_ecr_repository.app_cache.name
  policy     = file("${path.module}/aws_ecr_repository_policies/app_cache.json")
}

resource "aws_ecr_lifecycle_policy" "parser_cache" {
  repository = aws_ecr_repository.parser_cache.name
  policy     = file("${path.module}/aws_ecr_repository_policies/parser_cache.json")
}

resource "aws_ecr_lifecycle_policy" "transfer_cache" {
  repository = aws_ecr_repository.transfer_cache.name
  policy     = file("${path.module}/aws_ecr_repository_policies/transfer_cache.json")
}
