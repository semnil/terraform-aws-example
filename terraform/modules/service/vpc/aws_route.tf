# aws_route_table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name        = "${var.prefix}-public-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_route_table" "private1" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name        = "${var.prefix}-private1-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_route_table" "private2" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name        = "${var.prefix}-private2-${var.environment}"
    Environment = var.environment
  }
}

# aws_route
resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  gateway_id             = aws_internet_gateway.this.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route" "private1" {
  route_table_id         = aws_route_table.private1.id
  nat_gateway_id         = aws_nat_gateway.natg1.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route" "private2" {
  route_table_id         = aws_route_table.private2.id
  nat_gateway_id         = aws_nat_gateway.natg2.id
  destination_cidr_block = "0.0.0.0/0"
}

# aws_route_table_association
resource "aws_route_table_association" "public_alb1" {
  subnet_id      = aws_subnet.public_alb1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_alb2" {
  subnet_id      = aws_subnet.public_alb2.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "app1" {
  subnet_id      = aws_subnet.app1.id
  route_table_id = aws_route_table.private1.id
}

resource "aws_route_table_association" "app2" {
  subnet_id      = aws_subnet.app2.id
  route_table_id = aws_route_table.private2.id
}

resource "aws_route_table_association" "worker1" {
  subnet_id      = aws_subnet.worker1.id
  route_table_id = aws_route_table.private1.id
}

resource "aws_route_table_association" "worker2" {
  subnet_id      = aws_subnet.worker2.id
  route_table_id = aws_route_table.private2.id
}

resource "aws_route_table_association" "parser1" {
  subnet_id      = aws_subnet.parser1.id
  route_table_id = aws_route_table.private1.id
}

resource "aws_route_table_association" "parser2" {
  subnet_id      = aws_subnet.parser2.id
  route_table_id = aws_route_table.private2.id
}

resource "aws_route_table_association" "transfer1" {
  subnet_id      = aws_subnet.transfer1.id
  route_table_id = aws_route_table.private1.id
}

resource "aws_route_table_association" "transfer2" {
  subnet_id      = aws_subnet.transfer2.id
  route_table_id = aws_route_table.private2.id
}

resource "aws_route_table_association" "datastore1" {
  subnet_id      = aws_subnet.datastore1.id
  route_table_id = aws_route_table.private1.id
}

resource "aws_route_table_association" "datastore2" {
  subnet_id      = aws_subnet.datastore2.id
  route_table_id = aws_route_table.private2.id
}

resource "aws_route_table_association" "nat_gateway1" {
  subnet_id      = aws_subnet.nat_gateway1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "nat_gateway2" {
  subnet_id      = aws_subnet.nat_gateway2.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private_alb1" {
  subnet_id      = aws_subnet.private_alb1.id
  route_table_id = aws_route_table.private1.id
}

resource "aws_route_table_association" "private_alb2" {
  subnet_id      = aws_subnet.private_alb2.id
  route_table_id = aws_route_table.private2.id
}
