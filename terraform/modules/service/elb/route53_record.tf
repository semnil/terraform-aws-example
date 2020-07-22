# module "public_alb" {
#   source        = "../route53_alias_record"
#   zone_id       = var.public_zone_id
#   name          = "*.${var.public_zone_name}"
#   alias_name    = "dualstack.${aws_lb.public_alb.dns_name}"
#   alias_zone_id = aws_lb.public_alb.zone_id
# }
#
# module "private_alb_parser" {
#   source        = "../route53_alias_record"
#   zone_id       = var.private_zone_id
#   name          = "parser.${var.private_zone_name}"
#   alias_name    = "dualstack.${aws_lb.private_alb.dns_name}"
#   alias_zone_id = aws_lb.private_alb.zone_id
# }
