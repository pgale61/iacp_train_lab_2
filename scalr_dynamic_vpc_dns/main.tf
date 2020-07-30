# scalr-vpc-dns
#
# Manages a DNS enabled VPC with subnets in every AZ of the region

resource "aws_vpc" "scalr_vpc_dns" {
  cidr_block              = var.cidr
  enable_dns_support      = true
  enable_dns_hostnames    = true

  tags = {
    Name = "${var.prefix}-scalr-vpc"
  }
}

data "aws_availability_zones" "azs" {
  state = "available"
}

# Conditional expresssions
# expression ? true result : false result

locals {
  subnets = var.max_subnets > 0 && var.max_subnets <= length(data.aws_availability_zones.azs.zone_ids) ? var.max_subnets : length(data.aws_availability_zones.azs.zone_ids) 
}

resource "aws_subnet" "scalr_subnet" {
  count                     = local.subnets
    vpc_id                  = aws_vpc.scalr_vpc_dns.id
    availability_zone_id    = element(data.aws_availability_zones.azs.zone_ids,count.index)
    cidr_block = cidrsubnet(
                      aws_vpc.scalr_vpc_dns.cidr_block,
                      ceil(log(local.subnets * 2, 2)),
                      count.index
                 )
    map_public_ip_on_launch = true

    tags = {
      Name = "${var.prefix}-scalr-subnet-${count.index}"
    }

}