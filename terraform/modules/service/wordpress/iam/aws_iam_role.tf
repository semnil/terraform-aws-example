# aws_iam_role
resource "aws_iam_role" "wp" {
  name               = "${var.prefix}-wp-${var.environment}"
  path               = "/"
  assume_role_policy = file("${path.module}/aws_iam_policies/ecs_tasks_assume_role_policy.json")
}

resource "aws_iam_role" "wp_ec2" {
  name               = "${var.prefix}-wp-ec2-${var.environment}"
  path               = "/"
  assume_role_policy = file("${path.module}/aws_iam_policies/ec2_assume_role_policy.json")
}
