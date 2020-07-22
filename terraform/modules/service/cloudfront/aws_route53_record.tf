module "teaser" {
  source                 = "../route53_alias_record"
  zone_id                = data.aws_route53_zone.this.zone_id
  name                   = data.aws_route53_zone.this.name
  alias_name             = aws_cloudfront_distribution.teaser.domain_name
  alias_zone_id          = aws_cloudfront_distribution.teaser.hosted_zone_id
  evaluate_target_health = false
}
