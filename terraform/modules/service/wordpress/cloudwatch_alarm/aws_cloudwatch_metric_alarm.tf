# aws_cloudwatch_metric_alarm
module "public_alb" {
  source          = "../../cloudwatch_alarm/alb"
  environment     = var.environment
  prefix          = var.prefix
  name            = var.public_alb.name
  dimensions      = var.public_alb.dimensions
  sns_topic_arn   = var.sns_topic_arn
  actions_enabled = false
}

module "aurora" {
  source          = "../../cloudwatch_alarm/aurora"
  environment     = var.environment
  prefix          = var.prefix
  name            = var.aurora.name
  dimensions      = var.aurora.dimensions
  sns_topic_arn   = var.sns_topic_arn
  actions_enabled = false
}

module "ecs" {
  source          = "../../cloudwatch_alarm/ecs"
  environment     = var.environment
  prefix          = var.prefix
  name            = var.ecs.name
  dimensions      = var.ecs.dimensions
  sns_topic_arn   = var.sns_topic_arn
  actions_enabled = false
}

# Fargateに置き換え
# module "ec2" {
#   source          = "../../cloudwatch_alarm/ec2"
#   environment     = var.environment
#   prefix          = var.prefix
#   name            = var.ec2.name
#   dimensions      = var.ec2.dimensions
#   sns_topic_arn   = var.sns_topic_arn
#   actions_enabled = false
# }
