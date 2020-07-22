# worker_ec2
resource "aws_iam_role" "worker_ec2" {
  name               = "${var.prefix}-worker-ec2-${var.environment}"
  path               = "/"
  assume_role_policy = file("${path.module}/aws_iam_policies/ec2_assume_role_policy.json")
}
