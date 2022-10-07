terraform {
  backend "s3" {
    bucket = "remote-terraform-state-49th"
    key    = "prod/nessus/terraform.tfstate"
    region = "us-east-1"
  }
}
