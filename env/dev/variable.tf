variable "azurerm_resource_group" {
  type = map(object({
    location   = string
    managed_by = optional(string)
    tags       = optional(map(string))
  }))
}

variable "azurerm_virtual_network" {
  type = map(object({
    location                = string
    resource_group_name     = string
    address_space           = list(string)
    dns_servers             = optional(list(string))
    bgp_community           = optional(string)
    edge_zone               = optional(string)
    flow_timeout_in_minutes = optional(number)
    tags                    = optional(map(string))
  }))
}

variable "azurerm_subnet" {
  type = map(object({
    resource_group_name                           = string
    virtual_network_name                          = string
    address_prefixes                              = list(string)
    service_endpoints                             = optional(list(string))
    service_endpoint_policy_ids                   = optional(list(string))
    private_endpoint_network_policies_enabled     = optional(bool)
    private_link_service_network_policies_enabled = optional(bool)
  }))
}

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

variable "azurerm_network_security_group" {
  type = map(object({
    location            = string
    resource_group_name = string
    tags                = optional(map(string))
  }))
}

variable "azurerm_network_security_rule" {
  type = map(object({
    priority                     = number
    direction                    = string
    access                       = string
    protocol                     = string
    description                  = optional(string)
    source_port_range            = optional(string)
    source_port_ranges           = optional(list(string))
    destination_port_range       = optional(string)
    destination_port_ranges      = optional(list(string))
    source_address_prefix        = optional(string)
    source_address_prefixes      = optional(list(string))
    destination_address_prefix   = optional(string)
    destination_address_prefixes = optional(list(string))
    resource_group_name          = string
    network_security_group_name  = string
  }))
}

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

variable "azurerm_subnet_network_security_group_association" {
  type = map(object({
    subnet_id                   = optional(string)
    subnet_name                 = optional(string)
    virtual_network_name        = optional(string)
    resource_group_name         = string
    network_security_group_id   = optional(string)
    network_security_group_name = optional(string)
  }))
  default = {}
}

variable "subscription_id" {
  type = string
}

variable "backend_configution" {
  type = map(string)
}