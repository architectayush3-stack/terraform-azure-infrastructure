module "azurerm_resource_group" {
  source                 = "../../child/azurerm_resource_group"
  azurerm_resource_group = var.azurerm_resource_group
}

module "azurerm_virtual_network" {
  depends_on              = [module.azurerm_resource_group]
  source                  = "../../child/azurerm_virtual_network"
  azurerm_virtual_network = var.azurerm_virtual_network
}

module "azurerm_subnet" {
  depends_on     = [module.azurerm_virtual_network]
  source         = "../../child/azurerm_subnet"
  azurerm_subnet = var.azurerm_subnet
}

module "azurerm_public_ip" {
  depends_on        = [module.azurerm_resource_group]
  source            = "../../child/azurerm_public_ip"
  azurerm_public_ip = var.azurerm_public_ip
}

module "azurerm_network_security_group" {
  depends_on                     = [module.azurerm_resource_group]
  source                         = "../../child/azurerm_network_security_group"
  azurerm_network_security_group = var.azurerm_network_security_group
}

module "azurerm_network_security_rule" {
  depends_on                    = [module.azurerm_network_security_group]
  source                        = "../../child/azurerm_network_security_rule"
  azurerm_network_security_rule = var.azurerm_network_security_rule
}

module "azurerm_network_interface" {
  depends_on                = [module.azurerm_subnet, module.azurerm_public_ip]
  source                    = "../../child/azurerm_network_interface"
  azurerm_network_interface = var.azurerm_network_interface
}

module "azurerm_virtual_machine" {
  depends_on              = [module.azurerm_network_interface]
  source                  = "../../child/azurerm_virtual_machine"
  azurerm_virtual_machine = var.azurerm_virtual_machine
}

module "azurerm_postgresql_flexible_server" {
  depends_on                = [module.azurerm_resource_group]
  source                    = "../../child/azurerm_postgresql_flexible_server"
  azurerm_postgresql_server = var.azurerm_postgresql_server
}

module "azurerm_subnet_network_security_group_association" {
  depends_on                                        = [module.azurerm_subnet, module.azurerm_network_security_group]
  source                                            = "../../child/azurerm_subnet_network_security_group_association"
  azurerm_subnet_network_security_group_association = var.azurerm_subnet_network_security_group_association
}
