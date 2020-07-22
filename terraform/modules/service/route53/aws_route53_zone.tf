# aws_route53_zone
resource "aws_route53_zone" "private" {
  name    = "${var.domain_name}.local"
  comment = "Internal ${var.domain_name}"

  vpc {
    vpc_id = var.vpc_id
  }
}
