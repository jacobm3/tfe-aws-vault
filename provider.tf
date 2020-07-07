provider "vault" {
  address = "http://34.229.210.101:8200"
  namespace = "tfe-aws-vault"
}

data "vault_aws_access_credentials" "creds" {
  backend = "aws"
  role    = "s3-iam-role"
  type = "creds"
  #type    = "sts"
}

provider "aws" {
  access_key = data.vault_aws_access_credentials.creds.access_key
  secret_key = data.vault_aws_access_credentials.creds.secret_key
  #token = data.vault_aws_access_credentials.creds.security_token
  region = "us-east-1"
}
