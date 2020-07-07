`
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

vault token create -policy=space-admin 

vault login <-- space admin token
vault secrets enable aws
vault write aws/config/root \
access_key=$AWS_ACCESS_KEY_ID \
secret_key=$AWS_SECRET_ACCESS_KEY \
region=us-east-1

vault write aws/roles/s3-role \
    credential_type=federation_token \
    ttl=900s \
    policy_document=-<<EOF
{ "Version": "2012-10-17", "Statement": [ { "Effect": "Allow", "Action": "s3:*", "Resource": "*" } ] } 
EOF


vault read aws/creds/s3-role
`