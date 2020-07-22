data "aws_lb_listener" "listener" {
  arn = var.lb_listener_arn
}

data "aws_lb" "public_alb" {
  arn = data.aws_lb_listener.listener.load_balancer_arn
}
