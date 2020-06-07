provider "aws" {
  region = var.aws_region
}

module "lambda" {
  source = "./modules/lambda"

  name = "${var.stage}-${var.name}-function"

  deployment_package = var.deployment_package
  handler = var.handler
  runtime = var.runtime
  timeout = var.timeout
  memory_size = var.memory_size

  iam_role_for_lambda = module.iam.iam_role_for_lambda.arn

  subnet_ids = module.vpc.private_subnetes
  security_groups = [module.vpc.sg_for_lambda.id]

  efs_access_point_arn = module.efs.access_point_arn
  efs_mount_targets = module.efs.mount_targets

  local_mount_path = var.local_mount_path
}

module "api" {
  source     = "./modules/api"

  name       = "${var.stage}-${var.name}-api"
  method     = "ANY"
  lambda     = module.lambda.name
  lambda_arn = module.lambda.arn
  stage_name = var.stage

}

module "efs" {
  source = "./modules/efs"

  name = "${var.stage}-${var.name}-efs"
  subnet_ids = module.vpc.private_subnetes
  security_group_ids = [module.vpc.sg_for_lambda.id]
  provisioned_throughput = var.efs_provisioned_throughput
  throughput_mode = var.efs_throughput_mode
}

module "vpc" {
  source = "./modules/vpc"

  name = "${var.stage}-${var.name}-vpc"
  vpc_cidr = "10.0.0.0/16"
  azs = var.availability_zones
  public_subnet_cidrs = ["10.0.96.0/20", "10.0.112.0/20", "10.0.128.0/20"]
  private_subnet_cidrs = ["10.0.0.0/20", "10.0.16.0/20", "10.0.32.0/20"]
}

module "iam" {
  source = "./modules/iam"
}

