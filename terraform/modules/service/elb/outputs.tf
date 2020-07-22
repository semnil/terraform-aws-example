output "lb" {
  value = {
    public_alb  = aws_lb.public_alb
    private_alb = aws_lb.private_alb
  }
}

output "lb_listener" {
  value = {
    public_alb_http = aws_lb_listener.public_alb_http
    # public_alb_https = aws_lb_listener.public_alb_https
    private_alb_http = aws_lb_listener.private_alb_http
  }
}

output "lb_target_group" {
  value = {
    app    = aws_lb_target_group.app
    parser = aws_lb_target_group.parser
  }
}

# output "route53_record" {
#   value = {
#     public_alb         = module.public_alb.route53_record
#     private_alb_parser = module.private_alb_parser.route53_record
#   }
# }
