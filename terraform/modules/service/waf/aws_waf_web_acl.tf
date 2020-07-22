# aws_waf_web_acl
resource "aws_waf_web_acl" "this" {
  depends_on  = [aws_waf_ipset.this, aws_waf_rule.this]
  name        = "${var.prefix}-cloudfront-${var.environment}"
  metric_name = "${join("", regexall("[a-z]+", var.prefix))}cloudfront${var.environment}"

  default_action {
    type = "BLOCK"
  }

  rules {
    action {
      type = "ALLOW"
    }

    priority = 1
    rule_id  = aws_waf_rule.this.id
    type     = "REGULAR"
  }
}
