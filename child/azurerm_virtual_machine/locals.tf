locals {
  vm_nics = flatten([
    for vm_key, vm in var.azurerm_virtual_machine : [
      for idx, nic_name in(vm.network_interface_names != null ? vm.network_interface_names : []) : {
        key      = "${vm_key}-${nic_name}"
        vm_key   = vm_key
        nic_name = nic_name
        rg_name  = vm.resource_group_name
      }
    ]
  ])
}
