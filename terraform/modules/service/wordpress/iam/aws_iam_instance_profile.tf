# aws_iam_instance_profile
resource "aws_iam_instance_profile" "wp_ec2" {
  name = "${var.prefix}-wp-ec2-${var.environment}"
  path = "/"
  role = aws_iam_role.wp_ec2.name
}
