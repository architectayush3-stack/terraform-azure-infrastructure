resource "azurerm_network_security_group" "azurerm_network_security_group" {
  for_each            = var.azurerm_network_security_group
  name                = each.key
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  tags                = each.value.tags
}
