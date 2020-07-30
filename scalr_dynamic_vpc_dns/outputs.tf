output subnet_ids {
  value = aws_subnet.scalr_subnet.*.id
}

output subnet_cidrs {
  value = aws_subnet.scalr_subnet.*.cidr_block
}

output vpc_id {
  value = aws_vpc.scalr_vpc_dns.id
}