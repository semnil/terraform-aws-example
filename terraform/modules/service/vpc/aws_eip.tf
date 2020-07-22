# aws_eip
resource "aws_eip" "nat_gateway1" {
  depends_on = [aws_internet_gateway.this]
  vpc        = true

  tags = {
    Name        = "${var.prefix}-nat-gateway1-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_eip" "nat_gateway2" {
  depends_on = [aws_internet_gateway.this]
  vpc        = true

  tags = {
    Name        = "${var.prefix}-nat-gateway2-${var.environment}"
    Environment = var.environment
  }
}
