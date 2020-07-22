# aws_security_group
resource "aws_security_group" "public_alb" {
  name   = "${var.prefix}-alb-${var.environment}"
  vpc_id = aws_vpc.this.id

  dynamic "ingress" {
    # 任意のIP
    for_each = local.lb_ingress_sg

    content {
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = "tcp"
      cidr_blocks = ingress.value.ips
      description = ingress.value.name
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.prefix}-alb-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_security_group" "private_alb" {
  name   = "${var.prefix}-private-alb-${var.environment}"
  vpc_id = aws_vpc.this.id

  ingress {
    from_port   = "80"
    to_port     = "80"
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.this.cidr_block]
    description = "VPC/${aws_vpc.this.tags.Name}"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.prefix}-private-alb-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_security_group" "app" {
  name   = "${var.prefix}-app-${var.environment}"
  vpc_id = aws_vpc.this.id

  ingress {
    from_port       = "80"
    to_port         = "80"
    protocol        = "tcp"
    security_groups = [aws_security_group.public_alb.id]
    description     = "SG/${aws_security_group.public_alb.name}"
  }
  ingress {
    from_port       = "3000"
    to_port         = "3000"
    protocol        = "tcp"
    security_groups = [aws_security_group.public_alb.id]
    description     = "SG/${aws_security_group.public_alb.name}"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.prefix}-app-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_security_group" "worker" {
  name   = "${var.prefix}-worker-${var.environment}"
  vpc_id = aws_vpc.this.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.prefix}-worker-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_security_group" "parser" {
  name   = "${var.prefix}-parser-${var.environment}"
  vpc_id = aws_vpc.this.id

  ingress {
    from_port       = "3000"
    to_port         = "3000"
    protocol        = "tcp"
    security_groups = [aws_security_group.private_alb.id]
    description     = "SG/${aws_security_group.private_alb.name}"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.prefix}-parser-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_security_group" "transfer" {
  name   = "${var.prefix}-transfer-${var.environment}"
  vpc_id = aws_vpc.this.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.prefix}-transfer-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_security_group" "rds" {
  name   = "${var.prefix}-rds-${var.environment}"
  vpc_id = aws_vpc.this.id

  ingress {
    from_port   = "5432"
    to_port     = "5432"
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.this.cidr_block]
    description = "VPC/${aws_vpc.this.tags.Name}"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.prefix}-rds-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_security_group" "cache" {
  name   = "${var.prefix}-cache-${var.environment}"
  vpc_id = aws_vpc.this.id

  ingress {
    from_port   = "6379"
    to_port     = "6379"
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.this.cidr_block]
    description = "VPC/${aws_vpc.this.tags.Name}"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.prefix}-cache-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_security_group" "efs" {
  name   = "${var.prefix}-efs-${var.environment}"
  vpc_id = aws_vpc.this.id

  ingress {
    from_port   = "2049"
    to_port     = "2049"
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.this.cidr_block]
    description = "VPC/${aws_vpc.this.tags.Name}"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.prefix}-efs-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_security_group" "vpcendpoint" {
  name   = "${var.prefix}-vpce-${var.environment}"
  vpc_id = aws_vpc.this.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [aws_vpc.this.cidr_block]
    description = "VPC/${aws_vpc.this.tags.Name}"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.prefix}-vpce-${var.environment}"
    Environment = var.environment
  }
}
