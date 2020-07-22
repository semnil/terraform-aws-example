variable "prefix" {
  default = "terraform-aws-example"
}

variable "environment" {
  default = "dev"
}

variable "domain_name" {
  default = "terraform-aws-example.xyz"
}

variable "release_tag" {
  default = "latest"
}

variable "vpc_cidr_block" {
  default = "192.168.0.0/16"
}

variable "allow_public_access_ips" {
  default = [
    "0.0.0.0/0", # all
  ]
}
