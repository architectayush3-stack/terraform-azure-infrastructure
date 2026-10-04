resource "azurerm_public_ip" "azurerm_public_ip" {
  for_each                = var.azurerm_public_ip
  name                    = each.key
  resource_group_name     = each.value.resource_group_name
  location                = each.value.location
  allocation_method       = each.value.allocation_method
  sku                     = each.value.sku
  sku_tier                = each.value.sku_tier
  zones                   = each.value.zones
  domain_name_label       = each.value.domain_name_label
  idle_timeout_in_minutes = each.value.idle_timeout_in_minutes
  ip_tags                 = each.value.ip_tags

  public_ip_prefix_id = each.value.public_ip_prefix_id != null ? each.value.public_ip_prefix_id : (
    each.value.public_ip_prefix_name != null ? data.azurerm_public_ip_prefix.azurerm_public_ip_prefix[each.key].id : null
  )

  reverse_fqdn         = each.value.reverse_fqdn
  ddos_protection_mode = each.value.ddos_protection_mode
  tags                 = each.value.tags
}
