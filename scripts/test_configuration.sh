#!/usr/bin/env bash
export ENVIRONMENT=$1
export ORG_NAME=$(cat ${ENVIRONMENT}.auto.tfvars.json | jq -r .org_name)
export STACK_SLUG=$(cat ${ENVIRONMENT}.auto.tfvars.json | jq -r .stack_slug)
export STACK_NAME=$(cat ${ENVIRONMENT}.auto.tfvars.json | jq -r .stack_name)

terraform init
terraform workspace select ${ENVIRONMENT}
export API_KEY=$(terraform output -raw service_account_token_management_key)

bats test/validate_glc.bats

