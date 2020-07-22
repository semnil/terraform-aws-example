# aws_waf_rule
resource "aws_waf_rule" "this" {
  depends_on  = [aws_waf_ipset.this]
  name        = "allow-access-rule-${var.environment}"
  metric_name = "allowaccessrule${var.environment}"

  predicates {
    data_id = aws_waf_ipset.this.id
    negated = false
    type    = "IPMatch"
  }
}
