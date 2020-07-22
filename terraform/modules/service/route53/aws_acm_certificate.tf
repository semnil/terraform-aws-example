# aws_acm_certificate
resource "aws_acm_certificate" "this" {
  domain_name               = "*.${data.aws_route53_zone.this.name}"
  subject_alternative_names = [data.aws_route53_zone.this.name]
  validation_method         = "DNS"

  tags = {
    Name        = var.domain_name
    Environment = var.environment
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate" "cloudfront" {
  # Cloudfrontはus-east-1のACMのみ利用可能
  provider          = aws.us_east_1
  domain_name       = data.aws_route53_zone.this.name
  validation_method = "DNS"

  tags = {
    Name        = var.domain_name
    Environment = var.environment
  }

  lifecycle {
    create_before_destroy = true
  }
}

# aws_acm_certificate_validation
resource "aws_acm_certificate_validation" "this" {
  count                   = var.acm_validation == true ? 1 : 0
  certificate_arn         = aws_acm_certificate.this.arn
  validation_record_fqdns = [aws_route53_record.certificate.fqdn]
}
