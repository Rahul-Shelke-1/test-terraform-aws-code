provider "aws" {
  region = "ap-south-1"

  assume_role {
    role_arn     = "arn:aws:iam::730335512333:role/terraform_provisioning_role"
    session_name = "OpenTofu-Deployment"
  }
}
