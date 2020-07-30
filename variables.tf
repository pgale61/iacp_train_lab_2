variable "region" {
  description = "Region"
}

variable "instance_type" {
  description = "Instance Type"
  default     = "t3.nano"
}

variable cidr {
  description = "CIDR blockfor the VPC in format n.n.n.n/n. Subnet CIDR's will be generated to splut this range evenly across the subnets"
}

variable prefix {
 description = "Prefix for resource names"
}

variable svr_count {
  type = number
}