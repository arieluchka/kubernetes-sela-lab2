
#had to use chat gpt to figure out how to access the subnets id correctly
output "subnet-id" {
  value = tolist(azurerm_virtual_network.network-existing.subnet)[0].id
  description = "the id of the subnet"
}