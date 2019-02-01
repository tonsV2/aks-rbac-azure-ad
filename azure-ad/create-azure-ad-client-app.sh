#!/bin/bash
set -e

source .env

# generate manifest for client application
cat > ./manifest-client.json << EOF
[
    {
      "resourceAppId": "${RBAC_SERVER_APP_ID}",
      "resourceAccess": [
        {
          "id": "${RBAC_SERVER_APP_OAUTH2PERMISSIONS_ID}",
          "type": "Scope"
        }
      ]
    }
]
EOF

# create client application
az ad app create --display-name ${RBAC_CLIENT_APP_NAME} \
    --native-app \
    --reply-urls "${RBAC_CLIENT_APP_URL}" \
    --homepage "${RBAC_CLIENT_APP_URL}" \
    --required-resource-accesses @manifest-client.json

RBAC_CLIENT_APP_ID=$(az ad app list --display-name ${RBAC_CLIENT_APP_NAME} --query [].appId -o tsv)

# create service principal for the client application
az ad sp create --id ${RBAC_CLIENT_APP_ID}

# remove manifest-client.json
rm ./manifest-client.json

# grant permissions to server application
RBAC_CLIENT_APP_RESOURCES_API_IDS=$(az ad app permission list --id ${RBAC_CLIENT_APP_ID} --query [].resourceAppId --out tsv | xargs echo)
for RESOURCE_API_ID in ${RBAC_CLIENT_APP_RESOURCES_API_IDS};
do
  az ad app permission grant --api ${RESOURCE_API_ID} --id ${RBAC_CLIENT_APP_ID}
done

RBAC_AZURE_TENANT_ID=$(az ad sp list --display-name ${RBAC_CLIENT_APP_NAME} --query "[].appOwnerTenantId" --out tsv)

RBAC_AZURE_SUBSCRIPTION_ID=$(az account show --query id --out tsv)

echo "The following variables must be exported

export TF_VAR_rbac_server_app_id="${RBAC_SERVER_APP_ID}"
export TF_VAR_rbac_server_app_secret="${RBAC_SERVER_APP_SECRET}"
export TF_VAR_rbac_client_app_id="${RBAC_CLIENT_APP_ID}"
export TF_VAR_tenant_id="${RBAC_AZURE_TENANT_ID}""

#export TF_VAR_client_id=$(az ad sp list --query "[?appDisplayName == '$app_name']|[].appId" --out tsv)
#export TF_VAR_client_secret=$(az ad sp create-for-rbac --name $app_name --role="Contributor" --scopes="/subscriptions/$RBAC_AZURE_SUBSCRIPTION_ID" --query "password" --out tsv)
