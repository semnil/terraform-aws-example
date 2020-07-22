# aws_iam_role_policy_attachment
resource "aws_iam_role_policy_attachment" "wp_ec2_ecs" {
  role       = aws_iam_role.wp_ec2.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_role_policy_attachment" "wp_ec2_ssm_core" {
  role       = aws_iam_role.wp_ec2.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}
