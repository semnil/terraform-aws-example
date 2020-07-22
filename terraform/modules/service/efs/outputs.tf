output "efs_file_system" {
  value = {
    shared = aws_efs_file_system.shared
  }
}
