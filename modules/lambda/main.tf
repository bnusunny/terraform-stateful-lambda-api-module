provider "archive" {}

resource "aws_lambda_function" "lambda" {
  function_name = var.name

  filename         = var.deployment_package
  source_code_hash = filebase64sha256(var.deployment_package)

  role    = var.iam_role_for_lambda
  handler = var.handler
  runtime = var.runtime

  timeout = var.timeout
  memory_size = var.memory_size


  vpc_config {
    subnet_ids         = var.subnet_ids
    security_group_ids = var.security_groups
  }

  file_system_config {
    arn              = var.efs_access_point_arn
    local_mount_path = var.local_mount_path
  }

  # Explicitly declare dependency on EFS mount target.
  # When creating or updating Lambda functions, mount target must be in 'available' lifecycle state.
  depends_on = [var.efs_mount_targets]

}
