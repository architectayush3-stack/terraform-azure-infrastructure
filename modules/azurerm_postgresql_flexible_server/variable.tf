variable "azurerm_postgresql_server" {
  type = map(object({
    location                     = string
    resource_group_name          = string
    sku_name                     = optional(string)
    version                      = optional(string)
    delegated_subnet_id          = optional(string)
    private_dns_zone_id          = optional(string)
    administrator_login          = optional(string)
    administrator_password       = optional(string)
    zone                         = optional(string)
    storage_mb                   = optional(number)
    backup_retention_days        = optional(number)
    geo_redundant_backup_enabled = optional(bool)
    tags                         = optional(map(string))
  }))
}
