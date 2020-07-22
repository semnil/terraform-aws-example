output "vpc" {
  value = {
    this = aws_vpc.this
  }
}

output "subnet" {
  value = {
    public_alb = [
      aws_subnet.public_alb1,
      aws_subnet.public_alb2,
    ]
    app = [
      aws_subnet.app1,
      aws_subnet.app2,
    ]
    worker = [
      aws_subnet.worker1,
      aws_subnet.worker2,
    ]
    parser = [
      aws_subnet.parser1,
      aws_subnet.parser2,
    ]
    transfer = [
      aws_subnet.transfer1,
      aws_subnet.transfer2,
    ]
    datastore = [
      aws_subnet.datastore1,
      aws_subnet.datastore2,
    ]
    nat_gateway = [
      aws_subnet.nat_gateway1,
      aws_subnet.nat_gateway2,
    ]
    private_alb = [
      aws_subnet.private_alb1,
      aws_subnet.private_alb2,
    ]
  }
}

output "security_group" {
  value = {
    public_alb  = aws_security_group.public_alb
    private_alb = aws_security_group.private_alb
    app         = aws_security_group.app
    worker      = aws_security_group.worker
    parser      = aws_security_group.parser
    transfer    = aws_security_group.transfer
    rds         = aws_security_group.rds
    cache       = aws_security_group.cache
    efs         = aws_security_group.efs
  }
}

output "route_table" {
  value = {
    public   = aws_route_table.public
    private1 = aws_route_table.private1
    private2 = aws_route_table.private2
  }
}

output "eip" {
  value = {
    nat_gateway = [
      "${aws_eip.nat_gateway1.public_ip}/32",
      "${aws_eip.nat_gateway2.public_ip}/32",
    ]
  }
}
