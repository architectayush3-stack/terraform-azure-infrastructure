resource "azurerm_network_interface" "azurerm_network_interface" {
  for_each            = var.azurerm_network_interface
  name                = each.key
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  # enable_ip_forwarding          = each.value.enable_ip_forwarding
  # enable_accelerated_networking = each.value.enable_accelerated_networking
  tags = each.value.tags

  ip_configuration {
    name                          = each.value.ip_configuration_name
    private_ip_address_allocation = each.value.private_ip_address_allocation
    private_ip_address            = each.value.private_ip_address

    subnet_id = each.value.subnet_id != null ? each.value.subnet_id : (
      each.value.subnet_name != null && each.value.virtual_network_name != null ? data.azurerm_subnet.azurerm_subnet[each.key].id : null
    )

    public_ip_address_id = each.value.public_ip_address_id != null ? each.value.public_ip_address_id : (
      each.value.public_ip_name != null ? data.azurerm_public_ip.azurerm_public_ip[each.key].id : null
    )
  }
}
