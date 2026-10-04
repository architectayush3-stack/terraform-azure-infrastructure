variable "azurerm_subnet_network_security_group_association" {
  type = map(object({
    subnet_id                   = optional(string)
    subnet_name                 = optional(string)
    virtual_network_name        = optional(string)
    resource_group_name         = string
    network_security_group_id   = optional(string)
    network_security_group_name = optional(string)
  }))
}
