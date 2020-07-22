variable "environment" {}

variable "prefix" {}

variable "instance_type" {}

variable "spot_price" {
  default = null
}

variable "security_group_id" {}

variable "cluster_name" {}

variable "max_size" {}

variable "min_size" {}

variable "desired_capacity" {}

variable "subnet_ids" {}
