variable "azurerm_network_interface" {
  type = map(object({
    location                      = string
    resource_group_name           = string
    ip_configuration_name         = string
    private_ip_address_allocation = string
    subnet_id                     = optional(string)
    subnet_name                   = optional(string)
    virtual_network_name          = optional(string)
    private_ip_address            = optional(string)
    public_ip_address_id          = optional(string)
    public_ip_name                = optional(string)
    enable_ip_forwarding          = optional(bool)
    enable_accelerated_networking = optional(bool)
    tags                          = optional(map(string))
  }))
}
