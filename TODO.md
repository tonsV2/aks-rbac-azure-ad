# Disclaimer
* This is a POC!!! Not ready for production!
* Yes, the state is savable... But it's not done and there is no strategy in place
* Even if the state is saved it might not be good for anything if MS make changes to AKS such as removing the version of Kubernetes which is used... as it was done with 1.11.5  
* This file contains quite a few todo items... That's for a reason!




# Use map, indexed by workspace, to fetch vm_size and other stuff which might differ by environment
https://medium.com/capital-one-tech/deploying-multiple-environments-with-terraform-kubernetes-7b7f389e622

# Make password more secure... min_lower, min_numeric, min_special, min_upper, etc.

# We don't want an AD for each env... Let all env's authenticate against the same AD

# Find out which kind of vm to use for the new cluster
https://azure.microsoft.com/da-dk/pricing/details/virtual-machines/linux/#d-series

# Generate ssh key as part of init script

# Grant sp less privileges
https://github.com/lawrencegripper/azure-aks-terraform#least-privilidge

# Sp not in account issue...
* azurerm_kubernetes_cluster.k8s: Error creating/updating Managed Kubernetes Cluster "tons" (Resource Group "k8s-rg"): containerservice.ManagedClustersClient#CreateOrUpdate: Failure sending request: StatusCode=0 -- Original Error: Code="ServicePrincipalNotFound" Message="Service principal clientID: 8784b2fe-8de5-4a6b-b748-77d4a6c12090 not found in Active Directory tenant 6558925e-31cb-442f-88e0-3b0c475d4e38, Please see https://aka.ms/acs-sp-help for more details."

# Consider how to deal with multiple environments in terms of create-azure-ad-server-app.sh and create-azure-ad-client-app.sh

# Double or single square brackets... azure-ad/create-azure-ad-server-app.sh:35 - Intellij warning

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

Possible a script for creating new group (for new projects start)

# Use workspace postfix when creating AD groups... Or something. Consider how to handle dev, prod etc.

# Grant access only to a specific namespace

# Auto scale nodes
https://github.com/underguiz/terraform-aks-autoscaler

# Fix Dashboard permissions

# Grant rights using selenium?

# Store state remotely
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
