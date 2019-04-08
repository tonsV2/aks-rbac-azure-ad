#!/usr/bin/env bash

VAULT_NAME=terraform-storage

echo "
export TF_VAR_rbac_server_app_id=$(az keyvault secret show --name TF-VAR-rbac-server-app-id --vault-name ${VAULT_NAME} --query value -o tsv)
export TF_VAR_rbac_server_app_secret=$(az keyvault secret show --name TF-VAR-rbac-server-app-secret --vault-name ${VAULT_NAME} --query value -o tsv)
export TF_VAR_rbac_client_app_id=$(az keyvault secret show --name TF-VAR-rbac-client-app-id --vault-name ${VAULT_NAME} --query value -o tsv)
export TF_VAR_tenant_id=$(az keyvault secret show --name TF-VAR-tenant-id --vault-name ${VAULT_NAME} --query value -o tsv)

export ARM_ACCESS_KEY=$(az keyvault secret show --name ARM-ACCESS-KEY --vault-name ${VAULT_NAME} --query value -o tsv)
"
