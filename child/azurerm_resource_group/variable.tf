variable "azurerm_resource_group" {
  type = map(object({
    location   = string
    managed_by = optional(string)
    tags       = optional(map(string))
  }))
}
