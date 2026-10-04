resource "azurerm_linux_virtual_machine" "azurerm_virtual_machine" {
  for_each            = var.azurerm_virtual_machine
  name                = each.key
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  size                = each.value.vm_size
  admin_username      = each.value.admin_username
  admin_password      = each.value.admin_password
  disable_password_authentication = each.value.disable_password_authentication != null ? each.value.disable_password_authentication : false
  custom_data         = each.value.custom_data != null ? base64encode(each.value.custom_data) : null

  network_interface_ids = each.value.network_interface_ids != null ? each.value.network_interface_ids : [
    for nic in local.vm_nics : data.azurerm_network_interface.azurerm_network_interface[nic.key].id if nic.vm_key == each.key
  ]

  source_image_reference {
    publisher = each.value.publisher
    offer     = each.value.offer
    sku       = each.value.sku
    version   = each.value.version
  }

  os_disk {
    name                 = each.value.os_disk_name
    caching              = each.value.os_disk_caching
    storage_account_type = each.value.os_disk_managed_disk_type
  }

  tags = each.value.tags
}
