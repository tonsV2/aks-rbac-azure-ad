provider "azurerm" {
  version = "~>1.24"
}

terraform {
  backend "azurerm" {
#    storage_account_name = "tstate20034"
#    container_name = "tstate"
#    key = "terraform.tfstate"
  }
}
