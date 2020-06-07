# EFS file system
resource "aws_efs_file_system" "efs_for_lambda" {

  performance_mode = var.performance_mode
  throughput_mode = var.throughput_mode
  provisioned_throughput_in_mibps = var.provisioned_throughput

  tags = {
    Name = var.name
  }
}

# mount targets for each subnets
resource "aws_efs_mount_target" "mount_target" {
  count           = length(var.subnet_ids)
  file_system_id  = aws_efs_file_system.efs_for_lambda.id
  subnet_id       = var.subnet_ids[count.index]
  security_groups = var.security_group_ids
}

# EFS access point used by lambda file system
resource "aws_efs_access_point" "access_point_lambda" {
  file_system_id = aws_efs_file_system.efs_for_lambda.id

  root_directory {
    path = "/lambda"
    creation_info {
      owner_gid   = 1000
      owner_uid   = 1000
      permissions = "777"
    }
  }

  posix_user {
    gid = 1000
    uid = 1000
  }
}