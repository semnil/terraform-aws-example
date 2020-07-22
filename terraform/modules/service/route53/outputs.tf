output "route53_zone" {
  value = {
    this    = data.aws_route53_zone.this
    private = aws_route53_zone.private
  }
}

output "acm_certificate" {
  value = {
    this       = aws_acm_certificate.this
    cloudfront = aws_acm_certificate.cloudfront
  }
}
