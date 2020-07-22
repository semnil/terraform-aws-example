variable "environment" {}

variable "prefix" {}

variable "domain_name" {}

variable "acm_certificate_arn" {}

variable "s3_bucket" {}

variable "web_acl_id" {
  default = null
}
