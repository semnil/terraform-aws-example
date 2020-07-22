variable "environment" {}

variable "prefix" {}

variable "name" {}

variable "dimensions" {
  type = object({
    alb          = string
    target_group = string
  })
}

variable "sns_topic_arn" {}

variable "actions_enabled" {
  default = true
}
