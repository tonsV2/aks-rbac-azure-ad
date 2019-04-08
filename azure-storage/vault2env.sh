#!/usr/bin/env bash

source ../azure-ad/.env

RBAC_SERVER_APP_ID=$(az ad app list --display-name ${RBAC_SERVER_APP_NAME} --query [].appId -o tsv)
RBAC_SERVER_APP_SECRET=$(az keyvault secret show --name TF-VAR-rbac-server-app-secret --vault-name ${VAULT_NAME} --query value -o tsv)
RBAC_CLIENT_APP_ID=$(az ad app list --display-name ${RBAC_CLIENT_APP_NAME} --query [].appId -o tsv)
RBAC_AZURE_TENANT_ID=$(az account show --query tenantId --out tsv)

echo "The following variables must be exported

export TF_VAR_rbac_server_app_id="${RBAC_SERVER_APP_ID}"
export TF_VAR_rbac_server_app_secret="${RBAC_SERVER_APP_SECRET}"
export TF_VAR_rbac_client_app_id="${RBAC_CLIENT_APP_ID}"
export TF_VAR_tenant_id="${RBAC_AZURE_TENANT_ID}"
"
