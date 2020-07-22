# aws_route53_record
resource "aws_route53_record" "default" {
  zone_id = var.zone_id
  name    = var.name
  type    = "A"

  alias {
    name                   = var.alias_name
    zone_id                = var.alias_zone_id
    evaluate_target_health = var.evaluate_target_health
  }
}
