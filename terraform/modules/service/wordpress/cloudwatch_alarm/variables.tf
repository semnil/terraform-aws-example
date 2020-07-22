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

variable "aurora" {
  type = object({
    name = string
    dimensions = object({
      cluster = string
    })
  })
}

variable "ecs" {
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
