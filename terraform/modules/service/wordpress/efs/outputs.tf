output "efs_file_system" {
  value = {
    wp_shared = aws_efs_file_system.wp_shared
  }
}
