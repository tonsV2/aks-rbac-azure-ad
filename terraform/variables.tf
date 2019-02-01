variable "tenant_id" {}
variable "rbac_server_app_id" {}
variable "rbac_server_app_secret" {}
variable "rbac_client_app_id" {}

variable "kubernetes_version" {
  default = "1.11.5"
}

variable "agent_count" {
  default = 3
}

variable vm_size {
//  default = "Standard_DS2_v2"
  default = "Standard_D8s_v3"
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
  default = "tons"
}

variable location {
  default = "North Europe"
}
