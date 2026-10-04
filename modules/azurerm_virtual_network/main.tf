resource "azurerm_virtual_network" "azurerm_virtual_network" {
  for_each                = var.azurerm_virtual_network
  name                    = each.key
  location                = each.value.location
  resource_group_name     = each.value.resource_group_name
  address_space           = each.value.address_space
  dns_servers             = each.value.dns_servers
  bgp_community           = each.value.bgp_community
  edge_zone               = each.value.edge_zone
  flow_timeout_in_minutes = each.value.flow_timeout_in_minutes
  tags                    = each.value.tags
}
