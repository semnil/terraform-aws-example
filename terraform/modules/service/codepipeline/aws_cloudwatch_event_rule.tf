resource "aws_cloudwatch_event_rule" "app_repository" {
  name        = "${var.prefix}-app-repository-${var.environment}"
  description = "ECR ${var.app_repository_name} イメージタグ ${var.release_tag} の変更でECSへデプロイ"

  event_pattern = templatefile("${path.module}/aws_cloudwatch_event_rule_patterns/repository.json.tpl",
    {
      repository  = var.app_repository_name
      release_tag = var.release_tag
    }
  )
}

resource "aws_cloudwatch_event_rule" "parser_repository" {
  name        = "${var.prefix}-parser-repository-${var.environment}"
  description = "ECR ${var.parser_repository_name} イメージタグ ${var.release_tag} の変更でECSへデプロイ"

  event_pattern = templatefile("${path.module}/aws_cloudwatch_event_rule_patterns/repository.json.tpl",
    {
      repository  = var.parser_repository_name
      release_tag = var.release_tag
    }
  )
}

resource "aws_cloudwatch_event_target" "app_deploy_ecs" {
  target_id = "${var.prefix}-app-deploy-ecs-${var.environment}"
  rule      = aws_cloudwatch_event_rule.app_repository.name
  role_arn  = var.events_role_arn
  arn       = aws_codepipeline.app.arn
}

resource "aws_cloudwatch_event_target" "parser_deploy_ecs" {
  target_id = "${var.prefix}-parser-deploy-ecs-${var.environment}"
  rule      = aws_cloudwatch_event_rule.parser_repository.name
  role_arn  = var.events_role_arn
  arn       = aws_codepipeline.parser.arn
}
