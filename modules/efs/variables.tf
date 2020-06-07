variable "name" {
  description = "application name"
}


variable "subnet_ids" {
  description = "target subnet ids to mount efs file system"
  type = list(string)
  default = []
}

variable "security_group_ids" {
  description = "security group ids for the mount targets"
  type = list(string)
  default = []
}