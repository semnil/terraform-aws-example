# aws_subnet
resource "aws_subnet" "vpn1" {
  vpc_id                  = var.vpc.id
  cidr_block              = cidrsubnet(var.vpc.cidr_block, 8, 14)
  availability_zone       = var.aws_availability_zones.names[0]
  map_public_ip_on_launch = false

  tags = {
    Name        = "${var.prefix}-vpn1-${var.environment}"
    Environment = var.environment
  }
}
