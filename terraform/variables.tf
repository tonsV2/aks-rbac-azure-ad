variable "tenant_id" {}
variable "rbac_server_app_id" {}
variable "rbac_server_app_secret" {}
variable "rbac_client_app_id" {}

variable "aks_app_name" {
  default = "AKSAADCluster"
}

variable "service_principal_end_date" {
  default = "2299-12-30T23:00:00Z"
}

variable "kubernetes_version" {
  default = "1.12.5"
}

variable "agent_count" {
  default = 3
}

variable os_disk_size_gb {
  default = "100"
}

variable "ssh_public_key" {
  default = "~/.ssh/id_rsa.pub"
}

variable "dns_prefix" {
  default = "tons"
}

variable cluster_name {
  default = "tons"
}

variable resource_group_name {
  default = "aks"
}

variable location {
  default = "North Europe"
}

variable "workspace_to_vm_size" {
  type = "map"

  default = {
    default = "Standard_DS2_v2"
    dev = "Standard_DS2_v2"
    test = "Standard_DS2_v2"
    preprod = "Standard_DS2_v2"
    prod = "Standard_DS2_v2"
    janus = "Standard_D8s_v3"
  }
}
