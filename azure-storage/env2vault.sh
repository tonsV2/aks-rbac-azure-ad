#!/usr/bin/env bash

source .env

az group create --name ${RESOURCE_GROUP_NAME} --location ${LOCATION}
az keyvault create --name ${VAULT_NAME} --resource-group ${RESOURCE_GROUP_NAME} --location ${LOCATION}

az keyvault secret set --vault-name ${VAULT_NAME} --name TF-VAR-rbac-server-app-secret --value ${TF_VAR_rbac_server_app_secret}
az keyvault secret set --vault-name ${VAULT_NAME} --name ARM-ACCESS-KEY --value ${ARM_ACCESS_KEY}
