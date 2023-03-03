variable "resource_group_location" {
  default     = "northeurope"
  description = "Location of the resource group."
}

variable "resource_group_name_prefix" {
  default     = "rg"
  description = "Prefix of the resource group name that's combined with a random ID so name is unique in your Azure subscription."
}

# Vnet details
variable "vnet_config" {
    type = map(string)
    default = {
      vnetname = "CoreServiceNet"
      public_subnet = "PublicSubnet"      
      private_subnet = "PrivateSubnet"       
    }
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


# variable "script" {
#   default     = "Add-WindowsFeature Web-Server"
#   description = "Script to be executed."
# }
# variable "os_type" {
#   description = "Specifies the operating system type."
# }
# variable "virtual_machine_name" {
#   description = "The name of the virtual machine."
# }
# variable "command" {
#   default     = "Add-WindowsFeature Web-Server"
#   description = "Command to be executed."
# }
# variable "file_uris" {
#   type        = list
#   default     = []
#   description = "List of files to be downloaded."
# }