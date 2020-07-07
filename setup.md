## Create Vault namespace

    vault namespace create tfe-aws-vault

    export VAULT_NAMESPACE=tfe-aws-vault

    vault policy write space-admin - <<EOF
    path "*" {
    capabilities = ["create", "read", "update", "delete", "list", "sudo"]
    }
    path "auth/token/create" {
    capabilities = ["create", "update"]
    }
    EOF


## Login to Namespace

    vault token create -policy=space-admin 

    vault login <-- space admin token

## Core AWS Secrets Engine Config

    vault secrets enable aws

    vault write aws/config/root \
    access_key=$AWS_ACCESS_KEY_ID \
    secret_key=$AWS_SECRET_ACCESS_KEY \
    region=us-east-1

## Config Vault role to create IAM user 

    vault write aws/roles/s3-iam-role \
        credential_type=iam_user \
        ttl=600s \
        policy_document=-<<EOF
    { "Version": "2012-10-17", "Statement": [ { "Effect": "Allow", "Action": "s3:*", "Resource": "*" } ] } 
    EOF


    # vault read aws/creds/s3-role
    Key                Value
    ---                -----
    lease_id           aws/creds/s3-role/mMwZnuMMm5v5ljm7oGgCRHP9.vpqor
    lease_duration     1h
    lease_renewable    false
    access_key         ASIAZ5KZGVEGAXXXXXXX
    secret_key         hQkbjfmz1LXXXXXXXXXXXXXXXXXXXXXXXX
    security_token     FwoGZXIvYXdzEEIaDBd3DihuJ1P+EvB8/yK2AUG+83iUznQtWPEXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX==

## Config Vault role to create federated STS token

    vault write aws/roles/s3-sts-role \
        credential_type=federation_token \
        ttl=600s \
        policy_document=-<<EOF
    { "Version": "2012-10-17", "Statement": [ { "Effect": "Allow", "Action": "s3:*", "Resource": "*" } ] } 
    EOF


    # vault read aws/creds/s3-role
    Key                Value
    ---                -----
    lease_id           aws/creds/s3-role/mMwZnuMMm5v5ljm7oGgCRHP9.vpqor
    lease_duration     1h
    lease_renewable    false
    access_key         ASIAZ5KZGVEGAXXXXXXX
    secret_key         hQkbjfmz1LXXXXXXXXXXXXXXXXXXXXXXXX
    security_token     FwoGZXIvYXdzEEIaDBd3DihuJ1P+EvB8/yK2AUG+83iUznQtWPEXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX==
