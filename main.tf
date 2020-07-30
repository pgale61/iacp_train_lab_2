provider "aws" {
  region     = var.region
}

data "aws_ami" "the_ami" {
  most_recent = true
  filter {
    name   = "name"
    values = [ "ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*" ]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
  owners = [ "099720109477" ]
}

data "aws_security_group" "default_sg" {
  name = "default"
  vpc_id = module.scalr_dynamic_vpc_dns.vpc_id
}

module "scalr_dynamic_vpc_dns" {
  source            = "./scalr_dynamic_vpc_dns"
  cidr              = var.cidr
  prefix            = var.prefix
  max_subnets       = var.svr_count
}

resource "aws_instance" "scalr" {
  count                  = length(module.scalr_dynamic_vpc_dns.subnet_ids)
  ami                    = data.aws_ami.the_ami.id
  instance_type          = var.instance_type
  subnet_id              = module.scalr_dynamic_vpc_dns.subnet_ids[count.index]
  vpc_security_group_ids = [ data.aws_security_group.default_sg.id ]
}
