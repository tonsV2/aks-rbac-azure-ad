# Use terraform workspaces to create nonprod and prod cluster

# Use terraform workspaces to name resources
  tags {
    Environment = "${terraform.workspace}"
  }

# Use admin AD group... Not user
https://docs.microsoft.com/en-us/azure/aks/aad-integration

# Read only group

# Grant access only to a specific workspace

# Auto scale

# Fix Dashboard permissions

# Dashboard readonly

# Grant rights using selenium?

# Use backend for storing state
https://docs.microsoft.com/en-us/azure/terraform/terraform-backend

# Use vault

# Use keel

# Install elk stack

# Install prometheus/grafana stack

# Use letsencrypt... Somehow

# Istio... WTF is that? We probably need it
