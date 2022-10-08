provider "aws" {
  region = local.region
}

locals {
  region = "us-east-1"
}

resource "aws_key_pair" "deployer" {
  key_name   = "prod-key"
  public_key = file(pathexpand("~/.ssh/id_rsa.pub"))
}

data "http" "current_ip" {
  url = "https://api.ipify.org/?format=json"
}

resource "aws_ec2_managed_prefix_list" "consultants_list" {
  name = "Consultants-IPs"
  address_family = "IPv4"
  max_entries = 20

  entry {
    cidr = "${jsondecode(data.http.current_ip.response_body).ip}/32"
    description = "alex home"
  }

}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "main"
  cidr = "10.0.0.0/16"

  azs             = ["${local.region}a", "${local.region}b", "${local.region}c"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_ipv6 = true

  enable_nat_gateway = false
  single_nat_gateway = true
  enable_dns_hostnames = true
  public_subnet_ipv6_prefixes   = [0, 1, 3]

  vpc_tags = {
    Name = "vpc-name"
  }
}

resource "aws_security_group" "allow_all_consultants" {
  name = "allow_known"
  description = "allowing known things in"
  vpc_id = module.vpc.vpc_id
  tags = {
    Name = "allow_known"
  }
}

resource "aws_security_group_rule" "allow_all_consultants_rule" {
  type = "ingress"
  description = "all consultants"
  from_port = 0
  to_port = 0
  protocol = "-1"
  prefix_list_ids = [aws_ec2_managed_prefix_list.consultants_list.id]
  security_group_id = aws_security_group.allow_all_consultants.id
}

resource "aws_security_group_rule" "allow_all_outbound" {
  type = "egress"
  description = "allow all outbound"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  ipv6_cidr_blocks = ["::/0"]
  security_group_id = aws_security_group.allow_all_consultants.id
}
