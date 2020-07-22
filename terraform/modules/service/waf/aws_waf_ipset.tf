# aws_waf_ipset
resource "aws_waf_ipset" "this" {
  name = "allow-access-ips-${var.environment}"

  dynamic "ip_set_descriptors" {
    for_each = var.allow_public_access_ips

    content {
      type  = "IPV4"
      value = ip_set_descriptors.value
    }
  }
}
