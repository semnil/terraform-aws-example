resource "aws_ecr_repository" "app" {
  name = "${var.prefix}-app"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Environment = var.environment
  }
}

resource "aws_ecr_repository" "parser" {
  name = "${var.prefix}-parser"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Environment = var.environment
  }
}

resource "aws_ecr_repository" "transfer" {
  name = "${var.prefix}-transfer"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Environment = var.environment
  }
}

# CircleCIでイメージのビルドをキャッシュするために利用
resource "aws_ecr_repository" "app_cache" {
  name = "${var.prefix}-app-cache"

  tags = {
    Environment = var.environment
  }
}

resource "aws_ecr_repository" "parser_cache" {
  name = "${var.prefix}-parser-cache"

  tags = {
    Environment = var.environment
  }
}

resource "aws_ecr_repository" "transfer_cache" {
  name = "${var.prefix}-transfer-cache"

  tags = {
    Environment = var.environment
  }
}
