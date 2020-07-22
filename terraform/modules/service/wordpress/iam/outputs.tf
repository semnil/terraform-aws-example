output "iam_role" {
  value = {
    wp = aws_iam_role.wp
  }
}

output "iam_instance_profile" {
  value = {
    wp_ec2 = aws_iam_instance_profile.wp_ec2
  }
}
