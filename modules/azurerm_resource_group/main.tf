resource "azurerm_resource_group" "azurerm_resource_group" {
  for_each   = var.azurerm_resource_group
  name       = each.key
  location   = each.value.location
  managed_by = each.value.managed_by
  tags       = each.value.tags
}