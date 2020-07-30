# scalr_dynamic_vpc_dns module

Manages a VPC and dynamically created subnets in AWS.

1. VPC has DNS enabled
2. Subnets created dynamically based on max_subnets setting with VPC CIDR broken up evenly into CIDRs for the subnet.
3. Optional to make the subnets public