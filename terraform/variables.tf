variable "client_id" {}
variable "client_secret" {}
variable "tenant_id" {}
variable "rbac_server_app_id" {}
variable "rbac_server_app_secret" {}
variable "rbac_client_app_id" {}

variable "kubernetes_version" {
  default = "1.11.5"
}

variable "agent_count" {
  default = 1
}

variable "ssh_public_key" {
  default = "~/.ssh/id_rsa.pub"
}

variable "dns_prefix" {
  default = "azadk8s2"
}

variable cluster_name {
  default = "azadk8s2"
}

variable resource_group_name {
  default = "azure-ad-k8s2-rg"
}

variable location {
  default = "North Europe"
}

#TODO: output the below command populated with cluster name and resource_group_name
# $ az aks get-credentials -n azadk8s2 -g azure-ad-k8s2-rg --admin
