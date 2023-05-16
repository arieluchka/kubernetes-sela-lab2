output "subnet-id" {
  value = azurerm_subnet.subnet-existing.id
  description = "the id of the subnet"
}