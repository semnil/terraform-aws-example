output "security_group" {
  value = {
    wp    = aws_security_group.wp
    mysql = aws_security_group.mysql
  }
}
