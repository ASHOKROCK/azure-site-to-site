variable "resource_group_location" {
  default     = "northeurope"
  resource_group_location = "centralindia"
  description = "Location of the resource group."
}

variable "resource_group_name_prefix" {
  default     = "rg"
  description = "Prefix of the resource group name that's combined with a random ID so name is unique in your Azure subscription."
}

variable "vnet_cidr" {
  type = string
  description = "azure vnet cidr"
}
variable "public_subnet_address" {
  type = string
}
variable "private_subnet_address" {
  type = string
}
variable "gateway_subnet_address" {
  type = string
}

# On-prem values
variable "spoke1cidr" {
  type = string
}
variable "spoke2cidr" {
  type = string
}

variable "spoke1_Vm_pip" {
}

variable "spoke2_Vm_pip" {

}
