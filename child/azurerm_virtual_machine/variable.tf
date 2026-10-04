variable "azurerm_virtual_machine" {
  type = map(object({
    location                        = string
    resource_group_name             = string
    network_interface_ids           = optional(list(string))
    network_interface_names         = optional(list(string))
    vm_size                         = string
    publisher                       = optional(string)
    offer                           = optional(string)
    sku                             = optional(string)
    version                         = optional(string)
    os_disk_name                    = string
    os_disk_caching                 = optional(string)
    os_disk_create_option           = optional(string)
    os_disk_managed_disk_type       = optional(string)
    computer_name                   = string
    admin_username                  = string
    admin_password                  = optional(string)
    custom_data                     = optional(string)
    disable_password_authentication = optional(bool)
    tags                            = optional(map(string))
  }))
}
