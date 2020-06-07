module "lambda_file_system_api" {
  source = "../"

  stage = "dev"
  name = "lambda-file-system"

  deployment_package = "./dist/function.zip"
  handler = "app.lambda_handler"
  runtime = "python3.8"

//  efs_throughput_mode = "provisioned"
}