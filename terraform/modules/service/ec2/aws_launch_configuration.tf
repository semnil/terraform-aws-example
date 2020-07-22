resource "aws_launch_configuration" "worker" {
  image_id                    = data.aws_ami.ecs_optimized.id
  instance_type               = var.instance_type
  spot_price                  = var.spot_price
  iam_instance_profile        = aws_iam_instance_profile.worker_ec2.name
  security_groups             = [var.security_group_id]
  associate_public_ip_address = false
  ebs_optimized               = true
  user_data = templatefile("${path.module}/aws_launch_configuration_userdatas/worker.sh.tpl",
    {
      cluster = var.cluster_name,
    }
  )

  lifecycle {
    create_before_destroy = true
  }
}
