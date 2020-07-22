# aws_cloudwatch_metric_alarm
module "public_alb" {
  source        = "./alb"
  environment   = var.environment
  prefix        = var.prefix
  name          = var.public_alb.name
  dimensions    = var.public_alb.dimensions
  sns_topic_arn = var.sns_topic_arn
}

module "private_alb" {
  source        = "./alb"
  environment   = var.environment
  prefix        = var.prefix
  name          = var.private_alb.name
  dimensions    = var.private_alb.dimensions
  sns_topic_arn = var.sns_topic_arn
}

module "aurora" {
  source        = "./aurora"
  environment   = var.environment
  prefix        = var.prefix
  name          = var.aurora.name
  dimensions    = var.aurora.dimensions
  sns_topic_arn = var.sns_topic_arn
}

module "app" {
  source        = "./ecs"
  environment   = var.environment
  prefix        = var.prefix
  name          = var.ecs_app.name
  dimensions    = var.ecs_app.dimensions
  sns_topic_arn = var.sns_topic_arn
}

module "worker" {
  source        = "./ecs"
  environment   = var.environment
  prefix        = var.prefix
  name          = var.ecs_worker.name
  dimensions    = var.ecs_worker.dimensions
  sns_topic_arn = var.sns_topic_arn
}

module "parser" {
  source        = "./ecs"
  environment   = var.environment
  prefix        = var.prefix
  name          = var.ecs_parser.name
  dimensions    = var.ecs_parser.dimensions
  sns_topic_arn = var.sns_topic_arn
}

# Fargateに置き換え
# module "ec2" {
#   source        = "./ec2"
#   environment   = var.environment
#   prefix        = var.prefix
#   name          = var.ec2.name
#   dimensions    = var.ec2.dimensions
#   sns_topic_arn = var.sns_topic_arn
# }
