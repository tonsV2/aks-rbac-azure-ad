resource "azurerm_resource_group" "k8s" {
  name = "${var.resource_group_name}-${terraform.workspace}"
  location = "${var.location}"
}

resource "azurerm_azuread_application" "k8s" {
  # TODO: Use $var.name_prefix for all names
  # TODO: Promote this to a TF_VAR_*
  name = "AKSAADCluster-${terraform.workspace}"
}

resource "azurerm_azuread_service_principal" "k8s" {
  application_id = "${azurerm_azuread_application.k8s.application_id}"
}

resource "random_string" "password" {
  length = 32
  special = true
}

resource "azurerm_azuread_service_principal_password" "k8s" {
  end_date = "2299-12-30T23:00:00Z"
  service_principal_id = "${azurerm_azuread_service_principal.k8s.id}"
  value = "${random_string.password.result}"
}

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
    name = "default-${terraform.workspace}"
    count = "${var.agent_count}"
    vm_size = "${var.vm_size}"
    os_type = "Linux"
    os_disk_size_gb = "${var.os_disk_size_gb}"
  }

  service_principal {
    client_id = "${azurerm_azuread_application.k8s.application_id}"
    client_secret = "${azurerm_azuread_service_principal_password.k8s.value}"
  }

  tags {
    Environment = "${terraform.workspace}"
  }

  role_based_access_control {
    enabled = 1

    azure_active_directory {
      server_app_id = "${var.rbac_server_app_id}"
      server_app_secret = "${var.rbac_server_app_secret}"
      client_app_id = "${var.rbac_client_app_id}"
      tenant_id = "${var.tenant_id}"
    }
  }
}
