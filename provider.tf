data "vault_aws_access_credentials" "creds" {
  backend = "aws"
  role    = "s3-role"
}

provider "aws" {
  access_key = data.vault_aws_access_credentials.creds.access_key
  secret_key = data.vault_aws_access_credentials.creds.secret_key
  region = "us-east-1"
}
