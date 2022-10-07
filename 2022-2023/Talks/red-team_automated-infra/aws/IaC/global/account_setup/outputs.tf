output "prod_keypair" {
  value = aws_key_pair.deployer.key_name
}

output "consultants_prefix_list_id" {
  value = aws_ec2_managed_prefix_list.consultants_list.id
}

output "main_network_id" {
  value = module.vpc.public_subnets[0]
}

output "main_vpc_id" {
  value = module.vpc.vpc_id
}

output "sg_allow_all_consultants" {
  value = aws_security_group.allow_all_consultants.id
}
