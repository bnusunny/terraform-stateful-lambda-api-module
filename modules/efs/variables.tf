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

variable "performance_mode" {
  description = "The file system performance mode. Can be either 'generalPurpose' or 'maxIO' (Default: 'generalPurpose')"
  default = "generalPurpose"
}

variable "throughput_mode" {
  description = "Throughput mode for the file system. Defaults to bursting. Valid values: bursting, provisioned. When using provisioned, also set provisioned_throughput_in_mibps"
  default = null
}

variable "provisioned_throughput" {
  description = "The throughput, measured in MiB/s, that you want to provision for the file system. Only applicable with `throughput_mode` set to `provisioned`"
  default = null
}