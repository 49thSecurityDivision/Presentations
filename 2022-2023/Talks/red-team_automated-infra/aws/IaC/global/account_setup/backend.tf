terraform {
  backend "s3" {
    bucket = "remote-terraform-state-49th"
    key    = "global/account_setup/terraform.tfstate"
    region = "us-east-1"
  }
}
