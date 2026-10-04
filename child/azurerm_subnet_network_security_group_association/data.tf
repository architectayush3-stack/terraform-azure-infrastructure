data "azurerm_subnet" "azurerm_subnet" {
  for_each             = { for k, v in var.azurerm_subnet_network_security_group_association : k => v if v.subnet_id == null && v.subnet_name != null && v.virtual_network_name != null }
  name                 = each.value.subnet_name
  resource_group_name  = each.value.resource_group_name
  virtual_network_name = each.value.virtual_network_name
}

data "azurerm_network_security_group" "azurerm_network_security_group" {
  for_each            = { for k, v in var.azurerm_subnet_network_security_group_association : k => v if v.network_security_group_id == null && v.network_security_group_name != null }
  name                = each.value.network_security_group_name
  resource_group_name = each.value.resource_group_name
}
