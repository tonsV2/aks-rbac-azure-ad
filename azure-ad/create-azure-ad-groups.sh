#!/usr/bin/env bash

# TODO: Rename this script since it doesn't only create ad groups

GROUP_NAME=cluster-admin
MAIL_NICKNAME=snot # TODO: Wtf is this?

CLUSTER_ADMIN_GROUP_OBJECT_ID=$(az ad group show --group $GROUP_NAME --query objectId -o tsv)
if test -z "$CLUSTER_ADMIN_GROUP_OBJECT_ID"; then
  CLUSTER_ADMIN_GROUP_OBJECT_ID=$(az ad group create --display-name $GROUP_NAME --mail-nickname $MAIL_NICKNAME --query objectId -o tsv)
fi

# TODO: Turn this into a helmchart with a value for $CLUSTER_ADMIN_GROUP_OBJECT_ID (and metadata.name and possible others)
# In fact delete the folder k8s-rbac/ and don't every use kubectl apply
echo "apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: ad-cluster-admins
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
  - apiGroup: rbac.authorization.k8s.io
    kind: Group
    name: "$CLUSTER_ADMIN_GROUP_OBJECT_ID"" | kubectl apply -f -
