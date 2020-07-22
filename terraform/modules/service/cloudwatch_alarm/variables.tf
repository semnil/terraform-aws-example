variable "environment" {}

variable "prefix" {}

variable "sns_topic_arn" {}

variable "public_alb" {
  type = object({
    name = string
    dimensions = object({
      alb          = string
      target_group = string
    })
  })
}

variable "private_alb" {
  type = object({
    name = string
    dimensions = object({
      alb          = string
      target_group = string
    })
  })
}

variable "aurora" {
  type = object({
    name = string
    dimensions = object({
      cluster = string
    })
  })
}

variable "ecs_app" {
  type = object({
    name = string
    dimensions = object({
      cluster = string
      service = string
    })
  })
}

variable "ecs_worker" {
  type = object({
    name = string
    dimensions = object({
      cluster = string
      service = string
    })
  })
}

variable "ecs_parser" {
  type = object({
    name = string
    dimensions = object({
      cluster = string
      service = string
    })
  })
}

# Fargateに置き換え
# variable "ec2" {
#   type = object({
#     name = string
#     dimensions = object({
#       autoscaling_group = string
#     })
#   })
# }
