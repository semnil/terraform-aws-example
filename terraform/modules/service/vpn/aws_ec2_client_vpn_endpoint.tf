locals {
  # VPCの2番目のIPに予約されているDNSを利用する (*.*.*.2)
  amazon_dns = format("%s.0.2", join(".", chunklist(split(".", var.vpc.cidr_block), 2)[0]))
}

resource "aws_ec2_client_vpn_endpoint" "this" {
  description            = "${var.prefix}-vpn-${var.environment}"
  client_cidr_block      = var.client_cidr_block
  server_certificate_arn = var.server_certificate_arn
  transport_protocol     = "udp"
  split_tunnel           = false
  dns_servers            = [local.amazon_dns]

  authentication_options {
    type                       = "certificate-authentication"
    root_certificate_chain_arn = var.client_certificate_arn
  }

  connection_log_options {
    enabled               = true
    cloudwatch_log_group  = aws_cloudwatch_log_group.vpn.name
    cloudwatch_log_stream = aws_cloudwatch_log_stream.vpn.name
  }

  tags = {
    Name        = "${var.prefix}-vpn-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_ec2_client_vpn_network_association" "this" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.this.id
  subnet_id              = aws_subnet.vpn1.id
}
