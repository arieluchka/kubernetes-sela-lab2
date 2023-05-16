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
}

# opened subnets outside the vnet block, to get the id easier.
# one subnet for agent pool and one for pods

resource "azurerm_subnet" "subnet-existing" {
  name = "subnet-existing"
  resource_group_name = azurerm_resource_group.AKS-Cloud-ExistingNetwork.name
  virtual_network_name = azurerm_virtual_network.network-existing.name
  address_prefixes = ["10.1.0.0/16"]
}

resource "azurerm_subnet" "pod-subnet" {
  name                 = "pod-subnet"
  resource_group_name  = azurerm_resource_group.AKS-Cloud-ExistingNetwork.name
  virtual_network_name = azurerm_virtual_network.network-existing.name
  address_prefixes     = ["10.2.0.0/16"]
}

resource "azurerm_kubernetes_cluster" "AKS-Cloud" {
  name = "existingnetwork"
  resource_group_name = azurerm_resource_group.AKS-Cloud-ExistingNetwork.name
  location = var.location
  dns_prefix = "existingdns"

  default_node_pool {
    name = "existnode"
    node_count = 3
    vm_size = "Standard_D2_v2"
    pod_subnet_id = azurerm_subnet.pod-subnet.id
    vnet_subnet_id = azurerm_subnet.subnet-existing.id
  }
  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin = "azure"
  }
}