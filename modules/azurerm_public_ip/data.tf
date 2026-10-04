data "azurerm_public_ip_prefix" "azurerm_public_ip_prefix" {
  for_each            = { for k, v in var.azurerm_public_ip : k => v if v.public_ip_prefix_name != null }
  name                = each.value.public_ip_prefix_name
  resource_group_name = each.value.resource_group_name
}

