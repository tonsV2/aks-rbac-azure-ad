#
# Shouldn't resources have a label that indicates environment type instead of just "k8s" ?
#
resource "azurerm_resource_group" "k8s" {
  name = "${var.resource_group_name}-${terraform.workspace}"
  location = "${var.location}"
}

resource "azurerm_azuread_application" "k8s" {
  name = "${var.aks_app_name}-${terraform.workspace}"
}

resource "azurerm_azuread_service_principal" "k8s" {
  application_id = "${azurerm_azuread_application.k8s.application_id}"
}

resource "random_string" "password" {
  length = 32
}

resource "azurerm_azuread_service_principal_password" "k8s" {
  service_principal_id = "${azurerm_azuread_service_principal.k8s.id}"
  value = "${random_string.password.result}"
  end_date = "${var.service_principal_end_date}"

  # HACK: wait for service principal to come available
  provisioner "local-exec" {
    command = "sleep 10"
  }
}
/*
resource "azurerm_virtual_network" "k8s" {
  name = "vnet-${terraform.workspace}"
  location = "${azurerm_resource_group.k8s.location}"
  resource_group_name = "${azurerm_resource_group.k8s.name}"
  address_space = [
    "10.1.0.0/16"
  ]
}

resource "azurerm_subnet" "k8s" {
  name = "subnet-${terraform.workspace}"
  resource_group_name = "${azurerm_resource_group.k8s.name}"
  address_prefix = "10.1.0.0/24"
  virtual_network_name = "${azurerm_virtual_network.k8s.name}"
}
*/
resource "azurerm_kubernetes_cluster" "k8s" {
  name = "${var.cluster_name}-${terraform.workspace}"
  location = "${azurerm_resource_group.k8s.location}"
  resource_group_name = "${azurerm_resource_group.k8s.name}"
  dns_prefix = "${var.dns_prefix}"
  kubernetes_version = "${var.kubernetes_version}"

  linux_profile {
    admin_username = "ubuntu"

    ssh_key {
      key_data = "${file("${var.ssh_public_key}")}"
    }
  }

  agent_pool_profile {
    name = "default"
    count = "${var.agent_count}"
    vm_size = "${lookup(var.workspace_to_vm_size, terraform.workspace)}"
    os_type = "Linux"
    os_disk_size_gb = "${var.os_disk_size_gb}"
//    vnet_subnet_id = "${azurerm_subnet.k8s.id}"
  }

  service_principal {
    client_id = "${azurerm_azuread_application.k8s.application_id}"
    client_secret = "${azurerm_azuread_service_principal_password.k8s.value}"
  }

  tags {
    Environment = "${terraform.workspace}"
  }

  role_based_access_control {
    enabled = true

    azure_active_directory {
      server_app_id = "${var.rbac_server_app_id}"
      server_app_secret = "${var.rbac_server_app_secret}"
      client_app_id = "${var.rbac_client_app_id}"
      tenant_id = "${var.tenant_id}"
    }
  }
}
