resource "azurerm_resource_group" "k8s" {
  name = "${var.resource_group_name}"
  location = "${var.location}"
}

resource "azurerm_azuread_application" "k8s" {
  # TODO: Use $var.name_prefix for all names
  name = "${var.cluster_name}-sp"
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
  name = "${var.cluster_name}"
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
    vm_size = "${var.vm_size}"
    os_type = "Linux"
    os_disk_size_gb = 30
  }

  service_principal {
    client_id = "${azurerm_azuread_application.k8s.application_id}"
    client_secret = "${azurerm_azuread_service_principal_password.k8s.value}"
  }

  tags {
    Environment = "Development"
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
