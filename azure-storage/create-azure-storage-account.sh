#!/usr/bin/env bash

set -e

source .env

az group create --name ${RESOURCE_GROUP_NAME} --location ${LOCATION}
az storage account create --resource-group ${RESOURCE_GROUP_NAME} --name ${STORAGE_ACCOUNT_NAME} --sku Standard_LRS --encryption-services blob
ACCOUNT_KEY=$(az storage account keys list --resource-group ${RESOURCE_GROUP_NAME} --account-name ${STORAGE_ACCOUNT_NAME} --query [0].value -o tsv)
az storage container create --name ${CONTAINER_NAME} --account-name ${STORAGE_ACCOUNT_NAME} --account-key ${ACCOUNT_KEY}

echo "Use the following credentials when accessing the storage account
Storage account name: $STORAGE_ACCOUNT_NAME
Container name: $CONTAINER_NAME
Key: $KEY

export ARM_ACCESS_KEY=$ACCOUNT_KEY
terraform init -backend-config=\"storage_account_name=${STORAGE_ACCOUNT_NAME}\" -backend-config=\"container_name=${CONTAINER_NAME}\" -backend-config=\"key=${KEY}\"
"
