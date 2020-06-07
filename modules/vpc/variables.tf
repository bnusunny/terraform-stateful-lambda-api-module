variable "name" {
  description = "the name fo the vpc"
  default = "lambda-vpc"
}

variable "vpc_cidr" {
  description = "cidr range for the vpc"
  default = "10.0.0.0/16"
}

variable "azs" {
  description = "availability zones for the vpc"
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "public_subnet_cidrs" {
  description = "cidrs for public subnets"
  default = ["10.0.96.0/20", "10.0.112.0/20", "10.0.128.0/20"]
}

variable "private_subnet_cidrs" {
  description = "cidrs for private subnets"
  default = ["10.0.0.0/20", "10.0.16.0/20", "10.0.32.0/20"]
}
