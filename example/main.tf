module "lambda_file_system_api" {
  source = "github.com/bnusunny/terraform-stateful-lambda-api-module"

  stage = "dev"
  name = "lambda-file-system"

  deployment_package = "./dist/function.zip"
  handler = "app.lambda_handler"
  runtime = "python3.8"
  timeout = 29

}