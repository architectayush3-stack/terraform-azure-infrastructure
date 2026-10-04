variable "azurerm_public_ip" {
  type = map(object({
    resource_group_name     = string
    location                = string
    allocation_method       = string
    sku                     = optional(string)
    sku_tier                = optional(string)
    zones                   = optional(list(string))
    domain_name_label       = optional(string)
    idle_timeout_in_minutes = optional(number)
    ip_tags                 = optional(map(string))
    public_ip_prefix_id     = optional(string)
    public_ip_prefix_name   = optional(string)
    reverse_fqdn            = optional(string)
    ddos_protection_mode    = optional(string)
    tags                    = optional(map(string))
  }))
}
