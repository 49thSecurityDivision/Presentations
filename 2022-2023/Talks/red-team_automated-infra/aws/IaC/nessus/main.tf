terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

locals {
  ubuntu_version = "jammy-22.04"
  instance_type = "m5a.xlarge"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-${local.ubuntu_version}-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

data "terraform_remote_state" "account" {
  backend = "s3"
  config = {
    bucket  = "remote-terraform-state-49th"
    key     = "global/account_setup/terraform.tfstate"
    region  = "us-east-1"
  }
}


resource "aws_instance" "nessus" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = local.instance_type
  key_name = data.terraform_remote_state.account.outputs.prod_keypair
  associate_public_ip_address = true
  subnet_id = data.terraform_remote_state.account.outputs.main_network_id
  ipv6_address_count = 1
  root_block_device {
    volume_size = 30
    
  }


  vpc_security_group_ids = [
    data.terraform_remote_state.account.outputs.sg_allow_all_consultants
  ]

  tags = {
    Name = "NessusServer"
    OS = "ubuntu"
    Service = "nessus"
    Type = "scanning"
  }

  lifecycle {
    ignore_changes = [
      ami
    ]
  }
}
