resource "azurerm_subnet" "azurerm_subnet" {
  for_each                    = var.azurerm_subnet
  name                        = each.key
  resource_group_name         = each.value.resource_group_name
  virtual_network_name        = each.value.virtual_network_name
  address_prefixes            = each.value.address_prefixes
  service_endpoints           = each.value.service_endpoints
  service_endpoint_policy_ids = each.value.service_endpoint_policy_ids
  # private_endpoint_network_policies_enabled     = each.value.private_endpoint_network_policies_enabled
  private_link_service_network_policies_enabled = each.value.private_link_service_network_policies_enabled
}
