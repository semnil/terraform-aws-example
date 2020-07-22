# aws_security_group
resource "aws_security_group" "wp" {
  name   = "${var.prefix}-wp-${var.environment}"
  vpc_id = var.vpc_id

  ingress {
    from_port       = "80"
    to_port         = "80"
    protocol        = "tcp"
    security_groups = [var.ingress_security_group.id]
    description     = "SG/${var.ingress_security_group.name}"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.prefix}-wp-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_security_group" "mysql" {
  name   = "${var.prefix}-mysql-${var.environment}"
  vpc_id = var.vpc_id

  ingress {
    from_port   = "3306"
    to_port     = "3306"
    protocol    = "tcp"
    cidr_blocks = [var.cidr_block]
    description = "VPC/${var.prefix}-${var.environment}"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.prefix}-mysql-${var.environment}"
    Environment = var.environment
  }
}
