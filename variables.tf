variable "aws_region" {
  description = "The AWS region to create things in."
  default     = "us-east-1"
}

variable "stage" {
  description = "application stage/environment (dev, test, prod...)"
}

variable "name" {
  description = "application name"
}

variable "deployment_package" {
  description = "lambda deployment package"
}

variable "handler" {
  description = "lambda function handler"
}

variable "runtime" {
  description = "lambda function runtime"
}

variable "timeout" {
  description = "lambda function timeout"
  default = 3
}

variable "memory_size" {
  description = "lambda function memory size"
  default = 1024
}

variable "local_mount_path" {
  description = "local mount path inside lambda function. must start with '/mnt/'. default is '/mnt/shared'"
  default = "/mnt/shared"
}