# aws_network_acl
resource "aws_network_acl" "nat_gateway" {
  vpc_id = aws_vpc.this.id

  subnet_ids = [
    aws_subnet.nat_gateway1.id,
    aws_subnet.nat_gateway2.id,
  ]

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
    Name        = "${var.prefix}-nat-gateway-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_network_acl" "external" {
  vpc_id = aws_vpc.this.id

  subnet_ids = [
    aws_subnet.public_alb1.id,
    aws_subnet.public_alb2.id,
  ]

  dynamic "ingress" {
    # 許可IP * Port
    for_each = [
      for index, acl in local.lb_ingress_acl : {
        rule_no    = 100 + index
        port       = acl.port
        cidr_block = acl.ip
      }
    ]
    content {
      rule_no    = ingress.value.rule_no
      action     = "allow"
      from_port  = ingress.value.port
      to_port    = ingress.value.port
      protocol   = "tcp"
      cidr_block = ingress.value.cidr_block
    }
  }
  ingress {
    # ALBのヘルスチェックの一時ポート (1024-65535) を許可する必要がある
    rule_no    = 200
    action     = "allow"
    from_port  = 1024
    to_port    = 65535
    protocol   = "tcp"
    cidr_block = aws_vpc.this.cidr_block
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
    Name        = "${var.prefix}-external-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_network_acl" "internal" {
  vpc_id = aws_vpc.this.id

  subnet_ids = [
    aws_subnet.app1.id,
    aws_subnet.app2.id,
    aws_subnet.worker1.id,
    aws_subnet.worker2.id,
    aws_subnet.parser1.id,
    aws_subnet.parser2.id,
    aws_subnet.datastore1.id,
    aws_subnet.datastore2.id,
    aws_subnet.private_alb1.id,
    aws_subnet.private_alb2.id,
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
    Name        = "${var.prefix}-internal-${var.environment}"
    Environment = var.environment
  }
}
