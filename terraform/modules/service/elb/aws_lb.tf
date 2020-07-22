# aws_lb
resource "aws_lb" "public_alb" {
  name                       = "public-alb-${var.environment}"
  load_balancer_type         = "application"
  internal                   = false
  idle_timeout               = 60
  enable_deletion_protection = true
  subnets                    = var.public_subnet_ids

  access_logs {
    bucket  = var.s3_bucket
    enabled = true
  }

  security_groups = [var.public_security_group_id]

  tags = {
    Environment = var.environment
  }
}

resource "aws_lb" "private_alb" {
  name                       = "private-alb-${var.environment}"
  load_balancer_type         = "application"
  internal                   = true
  idle_timeout               = 60
  enable_deletion_protection = true
  subnets                    = var.private_subnet_ids

  access_logs {
    bucket  = var.s3_bucket
    enabled = true
  }

  security_groups = [var.private_security_group_id]

  tags = {
    Environment = var.environment
  }
}
