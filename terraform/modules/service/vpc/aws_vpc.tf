# aws_vpc
resource "aws_vpc" "this" {
  cidr_block           = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "${var.prefix}-${var.environment}"
    Environment = var.environment
  }
}
