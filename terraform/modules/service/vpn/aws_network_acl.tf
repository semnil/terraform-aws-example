# aws_network_acl
resource "aws_network_acl" "vpn" {
  vpc_id = var.vpc.id

  subnet_ids = [
    aws_subnet.vpn1.id,
  ]

  ingress {
    rule_no    = 1
    action     = "deny"
    from_port  = 22
    to_port    = 22
    protocol   = "tcp"
    cidr_block = "0.0.0.0/0"
  }
  ingress {
    rule_no    = 100
    action     = "allow"
    from_port  = 0
    to_port    = 0
    protocol   = "-1"
    cidr_block = "0.0.0.0/0"
  }
  egress {
    rule_no    = 100
    action     = "allow"
    from_port  = 0
    to_port    = 0
    protocol   = "-1"
    cidr_block = "0.0.0.0/0"
  }

  tags = {
    Name        = "${var.prefix}-vpn-${var.environment}"
    Environment = var.environment
  }
}
