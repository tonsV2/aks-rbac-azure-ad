#!/usr/bin/env bash

RANDOM="$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)"

RESOURCE_GROUP_NAME=tstate
STORAGE_ACCOUNT_NAME=tstate$RANDOM
CONTAINER_NAME=tstate
KEY=terraform.tfstate

LOCATION=northeurope

VAULT_NAME=terraform-backend-vault
VAULT_KEY=terraform-backend-key

# Create storage
az group create --name ${RESOURCE_GROUP_NAME} --location ${LOCATION}
az storage account create --resource-group ${RESOURCE_GROUP_NAME} --name ${STORAGE_ACCOUNT_NAME} --sku Standard_LRS --encryption-services blob
ACCOUNT_KEY=$(az storage account keys list --resource-group ${RESOURCE_GROUP_NAME} --account-name ${STORAGE_ACCOUNT_NAME} --query [0].value -o tsv)
az storage container create --name ${CONTAINER_NAME} --account-name ${STORAGE_ACCOUNT_NAME} --account-key ${ACCOUNT_KEY}

# Store storage key in vault
az keyvault create --name ${VAULT_NAME} --resource-group ${RESOURCE_GROUP_NAME} --location ${LOCATION}
az keyvault secret set --vault-name ${VAULT_NAME} --name ${VAULT_KEY} --value ${ACCOUNT_KEY}

echo "Use the following credentials when accessing the storage account
Storage account name: $STORAGE_ACCOUNT_NAME
Container name: $CONTAINER_NAME
Key: $KEY

export ARM_ACCESS_KEY=\$(az keyvault secret show --name ${VAULT_KEY} --vault-name ${VAULT_NAME} --query value -o tsv)
terraform init -backend-config=\"storage_account_name=${STORAGE_ACCOUNT_NAME}\" -backend-config=\"container_name=${CONTAINER_NAME}\" -backend-config=\"key=${KEY}\"
"
