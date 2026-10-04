variable "azurerm_network_security_group" {
  type = map(object({
    location            = string
    resource_group_name = string
    tags                = optional(map(string))
  }))
}
