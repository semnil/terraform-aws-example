# aws_efs_mount_target
resource "aws_efs_mount_target" "wp_shared" {
  count           = length(var.subnet_ids)
  file_system_id  = aws_efs_file_system.wp_shared.id
  subnet_id       = var.subnet_ids[count.index]
  security_groups = var.security_group_ids
}
