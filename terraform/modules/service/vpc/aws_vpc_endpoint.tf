# aws_vpc_endpoint
resource "aws_vpc_endpoint" "s3" {
  vpc_id            = aws_vpc.this.id
  service_name      = "com.amazonaws.${var.aws_region}.s3"
  vpc_endpoint_type = "Gateway"

  route_table_ids = [
    aws_route_table.public.id,
    aws_route_table.private1.id,
    aws_route_table.private2.id,
  ]

  tags = {
    Name        = "${var.prefix}-s3-${var.environment}"
    Environment = var.environment
  }
}

# 1AZあたり10ドル/月かかるので必要になるまでは作成しない
# resource "aws_vpc_endpoint" "sqs" {
#   vpc_id              = aws_vpc.this.id
#   service_name        = "com.amazonaws.${var.aws_region}.sqs"
#   vpc_endpoint_type   = "Interface"
#   private_dns_enabled = true
#   security_group_ids  = [aws_security_group.vpcendpoint.id]
#
#   subnet_ids = [
#     aws_subnet.app1.id,
#     aws_subnet.app2.id,
#     aws_subnet.worker1.id,
#     aws_subnet.worker2.id,
#   ]
#
#   tags = {
#     Name        = "${var.prefix}-sqs-${var.environment}"
#     Environment = var.environment
#   }
# }
