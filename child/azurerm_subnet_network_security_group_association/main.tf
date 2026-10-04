resource "azurerm_subnet_network_security_group_association" "azurerm_subnet_network_security_group_association" {
  for_each = var.azurerm_subnet_network_security_group_association

  subnet_id = each.value.subnet_id != null ? each.value.subnet_id : (
    each.value.subnet_name != null && each.value.virtual_network_name != null ? data.azurerm_subnet.azurerm_subnet[each.key].id : null
  )

  network_security_group_id = each.value.network_security_group_id != null ? each.value.network_security_group_id : (
    each.value.network_security_group_name != null ? data.azurerm_network_security_group.azurerm_network_security_group[each.key].id : null
  )
}
