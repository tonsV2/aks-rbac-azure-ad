# Use terraform workspaces to create nonprod and prod cluster

# Use terraform workspaces to name resources. All name properties should be post fixed with -workspace-name
  tags {
    Environment = "${terraform.workspace}"
  }

Also use $var.name_prefix for all names. Eg. $var.name_prefix + name + $terraform.workspace

# Use admin AD group... Not user
https://docs.microsoft.com/en-us/azure/aks/aad-integration

# Initial AAD groups... cluster-admin, dashboard, dashboard-reader
https://docs.microsoft.com/en-us/cli/azure/ad/group?view=azure-cli-latest

!!!Create rolebindings and roles using object id's from the above commands

Extend create-azure-ad-groups.sh to also cover dashboard, dashboard-reader and other groups


# Grant access only to a specific namespace

# Auto scale nodes
https://github.com/underguiz/terraform-aks-autoscaler

# Fix Dashboard permissions

# Grant rights using selenium?

# Use backend for storing state
https://docs.microsoft.com/en-us/azure/terraform/terraform-backend

# Use vault - Our current handling of sensitive data is not acceptable! Right, Per?
https://github.com/tolitius/cault
https://learn.hashicorp.com/vault/getting-started/install
https://github.com/hashicorp/terraform-guides/blob/master/infrastructure-as-code/k8s-cluster-aks/main.tf

# Use keel

# Install elk stack

# Install prometheus/grafana stack

# Use letsencrypt... Somehow

# Istio... WTF is that? We probably need it

# Move the export commands out of create-azure-ad-server-app.sh and create-azure-ad-client-app.sh

# Security.. Sign charts
https://github.com/helm/helm/blob/master/docs/provenance.md
