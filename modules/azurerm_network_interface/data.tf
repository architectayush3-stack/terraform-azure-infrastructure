data "azurerm_subnet" "azurerm_subnet" {
  for_each             = { for k, v in var.azurerm_network_interface : k => v if v.subnet_name != null && v.virtual_network_name != null }
  name                 = each.value.subnet_name
  resource_group_name  = each.value.resource_group_name
  virtual_network_name = each.value.virtual_network_name
}

data "azurerm_public_ip" "azurerm_public_ip" {
  for_each            = { for k, v in var.azurerm_network_interface : k => v if v.public_ip_name != null }
  name                = each.value.public_ip_name
  resource_group_name = each.value.resource_group_name
}