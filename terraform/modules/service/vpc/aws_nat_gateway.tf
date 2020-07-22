# aws_nat_gateway
resource "aws_nat_gateway" "natg1" {
  depends_on    = [aws_internet_gateway.this]
  allocation_id = aws_eip.nat_gateway1.id
  subnet_id     = aws_subnet.nat_gateway1.id

  tags = {
    Name        = "${var.prefix}-nat-gateway1-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_nat_gateway" "natg2" {
  depends_on    = [aws_internet_gateway.this]
  allocation_id = aws_eip.nat_gateway2.id
  subnet_id     = aws_subnet.nat_gateway2.id

  tags = {
    Name        = "${var.prefix}-nat-gateway2-${var.environment}"
    Environment = var.environment
  }
}
