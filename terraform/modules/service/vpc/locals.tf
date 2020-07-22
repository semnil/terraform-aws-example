locals {
  # LBアクセスを許可するIP
  # IP制限なしの場合は不要なIPを除外
  lb_ingress_ips = contains(var.lb_ingress_ips, "0.0.0.0/0") ? { whitelist = ["0.0.0.0/0"] } : {
    # NatGatewayのループバック用
    nat_gateway = [
      "${aws_eip.nat_gateway1.public_ip}/32",
      "${aws_eip.nat_gateway2.public_ip}/32",
    ],
    whitelist = var.lb_ingress_ips
  }
  # LBアクセスを許可するPort
  lb_ingress_ports = [
    "80",
    "443",
  ]
}
locals {
  # LBアクセスを許可するIP*Port組み合わせ（SecurityGroup用）
  lb_ingress_sg = flatten([
    for name, ips in local.lb_ingress_ips : [
      for port in local.lb_ingress_ports : {
        name = join("", [for word in split("_", name) : title(word)]) # CamelCase
        ips  = ips
        port = port
      }
    ]
  ])
  # LBアクセスを許可するIP*Port組み合わせ（ネットワークACL用）
  lb_ingress_acl = flatten([
    for name, ips in local.lb_ingress_ips : [
      for ip_port in setproduct(ips, local.lb_ingress_ports) : {
        name = join("", [for word in split("_", name) : title(word)]) # CamelCase
        ip   = ip_port[0]
        port = ip_port[1]
      }
    ]
  ])
}
