output "access_point_arn" {
  value = aws_efs_access_point.access_point_lambda.arn
}

output "mount_targets" {
  value = aws_efs_mount_target.mount_target
}