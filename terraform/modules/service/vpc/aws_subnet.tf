# aws_subnet
resource "aws_subnet" "public_alb1" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = cidrsubnet(aws_vpc.this.cidr_block, 8, 0)
  availability_zone       = var.aws_availability_zones.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.prefix}-alb1-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_subnet" "public_alb2" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = cidrsubnet(aws_vpc.this.cidr_block, 8, 1)
  availability_zone       = var.aws_availability_zones.names[1]
  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.prefix}-alb2-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_subnet" "app1" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = cidrsubnet(aws_vpc.this.cidr_block, 8, 2)
  availability_zone       = var.aws_availability_zones.names[0]
  map_public_ip_on_launch = false

  tags = {
    Name        = "${var.prefix}-app1-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_subnet" "app2" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = cidrsubnet(aws_vpc.this.cidr_block, 8, 3)
  availability_zone       = var.aws_availability_zones.names[1]
  map_public_ip_on_launch = false

  tags = {
    Name        = "${var.prefix}-app2-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_subnet" "worker1" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = cidrsubnet(aws_vpc.this.cidr_block, 8, 4)
  availability_zone       = var.aws_availability_zones.names[0]
  map_public_ip_on_launch = false

  tags = {
    Name        = "${var.prefix}-worker1-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_subnet" "worker2" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = cidrsubnet(aws_vpc.this.cidr_block, 8, 5)
  availability_zone       = var.aws_availability_zones.names[1]
  map_public_ip_on_launch = false

  tags = {
    Name        = "${var.prefix}-worker2-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_subnet" "parser1" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = cidrsubnet(aws_vpc.this.cidr_block, 8, 6)
  availability_zone       = var.aws_availability_zones.names[0]
  map_public_ip_on_launch = false

  tags = {
    Name        = "${var.prefix}-parser1-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_subnet" "parser2" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = cidrsubnet(aws_vpc.this.cidr_block, 8, 7)
  availability_zone       = var.aws_availability_zones.names[1]
  map_public_ip_on_launch = false

  tags = {
    Name        = "${var.prefix}-parser2-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_subnet" "datastore1" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = cidrsubnet(aws_vpc.this.cidr_block, 8, 8)
  availability_zone       = var.aws_availability_zones.names[0]
  map_public_ip_on_launch = false

  tags = {
    Name        = "${var.prefix}-datastore1-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_subnet" "datastore2" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = cidrsubnet(aws_vpc.this.cidr_block, 8, 9)
  availability_zone       = var.aws_availability_zones.names[1]
  map_public_ip_on_launch = false

  tags = {
    Name        = "${var.prefix}-datastore2-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_subnet" "nat_gateway1" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = cidrsubnet(aws_vpc.this.cidr_block, 8, 10)
  availability_zone       = var.aws_availability_zones.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.prefix}-nat-gateway1-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_subnet" "nat_gateway2" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = cidrsubnet(aws_vpc.this.cidr_block, 8, 13)
  availability_zone       = var.aws_availability_zones.names[1]
  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.prefix}-nat-gateway2-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_subnet" "private_alb1" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = cidrsubnet(aws_vpc.this.cidr_block, 8, 11)
  availability_zone       = var.aws_availability_zones.names[0]
  map_public_ip_on_launch = false

  tags = {
    Name        = "${var.prefix}-private-alb1-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_subnet" "private_alb2" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = cidrsubnet(aws_vpc.this.cidr_block, 8, 12)
  availability_zone       = var.aws_availability_zones.names[1]
  map_public_ip_on_launch = false

  tags = {
    Name        = "${var.prefix}-private-alb2-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_subnet" "transfer1" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = cidrsubnet(aws_vpc.this.cidr_block, 8, 15)
  availability_zone       = var.aws_availability_zones.names[0]
  map_public_ip_on_launch = false

  tags = {
    Name        = "${var.prefix}-transfer1-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_subnet" "transfer2" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = cidrsubnet(aws_vpc.this.cidr_block, 8, 16)
  availability_zone       = var.aws_availability_zones.names[1]
  map_public_ip_on_launch = false

  tags = {
    Name        = "${var.prefix}-transfer2-${var.environment}"
    Environment = var.environment
  }
}
