module "lambda_file_system_api" {
  source = "../"

  aws_region = "us-east-1"
  stage = "dev"
  name = "lfs"

  deployment_package = "./dist/function.zip"
  handler = "app.lambda_handler"
  runtime = "python3.7"

  local_mount_path = "/mnt/shared"

}