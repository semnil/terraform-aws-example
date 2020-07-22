# aws_security_group
resource "aws_security_group" "vpn" {
  name   = "${var.prefix}-vpn-${var.environment}"
  vpc_id = var.vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.vpc.cidr_block]
    description = "VPC/${var.vpc.tags.Name}"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.prefix}-vpn-${var.environment}"
    Environment = var.environment
  }
}
