
module "module_dev" {
  source = "./modules"
  resource_group_location = "centralindia"
  vnet_cidr = "10.6.0.0/16"
  public_subnet_address = "10.6.1.0/24"
  private_subnet_address = "10.6.2.0/24"
  gateway_subnet_address = "10.6.3.0/24"
  # Simulated on-prem details
  spoke1cidr = "10.1.0.0/16" 
  spoke2cidr = "10.2.0.0/16"
  spoke1_Vm_pip = "87.49.45.127" 
  spoke2_Vm_pip = "87.49.45.127"
}