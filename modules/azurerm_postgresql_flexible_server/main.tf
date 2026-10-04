resource "azurerm_postgresql_flexible_server" "azurerm_postgresql_flexible_server" {
  for_each            = var.azurerm_postgresql_server
  name                = each.key
  resource_group_name = each.value.resource_group_name
  location            = each.value.location

  version                      = each.value.version
  delegated_subnet_id          = each.value.delegated_subnet_id
  private_dns_zone_id          = each.value.private_dns_zone_id
  administrator_login          = each.value.administrator_login
  administrator_password       = each.value.administrator_password
  zone                         = each.value.zone
  storage_mb                   = each.value.storage_mb
  sku_name                     = each.value.sku_name
  backup_retention_days        = each.value.backup_retention_days
  geo_redundant_backup_enabled = each.value.geo_redundant_backup_enabled
  tags                         = each.value.tags
}
