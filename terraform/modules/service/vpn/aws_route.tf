# aws_route_table_association
resource "aws_route_table_association" "vpn1" {
  subnet_id      = aws_subnet.vpn1.id
  route_table_id = var.route_table_ids[0]
}
