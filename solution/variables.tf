variable "subscription_id" {
  type = string
  default = "7a84147b-4a40-4a62-8fea-103e8d1122ec"
}

variable "tenant_id" {
  type = string
  default = "38a7c9d3-a9ef-4319-907e-9e199ee8eb8e"
}

#the location is eastus instead if central us because the vm size isnt available on central
variable "location" {
  type = string
  default = "eastus"
}

# variable "subnet_id" {
#   type = string
#   default = tolist(azurerm_virtual_network.network-existing.subnet)[0].id
# }