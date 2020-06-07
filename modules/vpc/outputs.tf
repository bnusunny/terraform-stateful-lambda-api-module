output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnets" {
  value = module.vpc.public_subnets
}

output "private_subnetes" {
  value = module.vpc.private_subnets
}

output "sg_for_lambda" {
  value = aws_security_group.sg_lambda
}
