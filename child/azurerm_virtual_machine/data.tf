
data "azurerm_network_interface" "azurerm_network_interface" {
  for_each            = { for nic in local.vm_nics : nic.key => nic }
  name                = each.value.nic_name
  resource_group_name = each.value.rg_name
}
