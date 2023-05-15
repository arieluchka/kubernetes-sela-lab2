terraform {
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = "=3.45.0"
    }
  }
}

provider "azurerm" {
  subscription_id = var.subscription_id
  tenant_id = var.tenant_id
  features {}
}

resource "azurerm_resource_group" "AKS-Cloud-ExistingNetwork" {
  name = "AKS-Cloud-ExistingNetwork"
  location = var.location
}

resource "azurerm_virtual_network" "network-existing" {
  name = "AKS-Cloud-ExistingNetwork"
  location = var.location
  resource_group_name = azurerm_resource_group.AKS-Cloud-ExistingNetwork.name
  address_space = ["10.0.0.0/12"]

  subnet {
    name = "subnet-existing"
    address_prefix = "10.1.0.0/16"
  }
}

