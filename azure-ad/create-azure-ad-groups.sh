#!/usr/bin/env bash

GROUP_NAME=cluster-admin
MAIL_NICKNAME=snot

CLUSTER_ADMIN_OBJECT_ID=$(az ad group show --group $GROUP_NAME --query objectId -o tsv)
if test -z "$CLUSTER_ADMIN_OBJECT_ID"; then
  CLUSTER_ADMIN_OBJECT_ID=$(az ad group create --display-name $GROUP_NAME --mail-nickname $MAIL_NICKNAME --query objectId -o tsv)
fi

echo "apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: aad-cluster-admins
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
  - apiGroup: rbac.authorization.k8s.io
    kind: Group
    name: "$CLUSTER_ADMIN_OBJECT_ID"" | kubectl apply -f -
