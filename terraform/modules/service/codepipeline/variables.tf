variable "environment" {}

variable "prefix" {}

variable "release_tag" {}

variable "app_repository_name" {}

variable "app_repository_url" {}

variable "parser_repository_name" {}

variable "parser_repository_url" {}

variable "s3_bucket" {}

variable "role_arn" {}

variable "kms_key_arn" {}

variable "cluster_name" {}

variable "app_service_name" {}

variable "worker_service_name" {}

variable "parser_service_name" {}

variable "events_role_arn" {}

variable "approval_app" {
  description = "appリポジトリデプロイ時のマニュアル承認を有効にする"
  default     = true
}

variable "approval_parser" {
  description = "parserリポジトリデプロイ時のマニュアル承認を有効にする"
  default     = true
}
