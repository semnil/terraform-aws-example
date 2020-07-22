# aws_launch_configuration
resource "aws_launch_configuration" "wp" {
  image_id                    = data.aws_ami.ecs_optimized.id
  instance_type               = var.instance_type
  spot_price                  = var.spot_price
  iam_instance_profile        = var.iam_instance_profile
  security_groups             = [var.security_group_id]
  associate_public_ip_address = false
  ebs_optimized               = true
  user_data = templatefile("${path.module}/aws_launch_configuration_userdatas/wp.sh.tpl",
    {
      cluster = var.cluster_name,
    }
  )

  lifecycle {
    create_before_destroy = true
  }
}
