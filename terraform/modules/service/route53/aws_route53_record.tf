# aws_route53_record
resource "aws_route53_record" "certificate" {
  zone_id = data.aws_route53_zone.this.zone_id
  name    = aws_acm_certificate.this.domain_validation_options[0].resource_record_name
  type    = aws_acm_certificate.this.domain_validation_options[0].resource_record_type
  records = [aws_acm_certificate.this.domain_validation_options[0].resource_record_value]
  ttl     = 60
}
