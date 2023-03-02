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
  default = ["10.6.0.0/16"]
}
variable "public_subnet_address" {
  default = ["10.6.1.0/24"]
}
variable "private_subnet_address" {
  default = ["10.6.2.0/24"]
}
variable "gateway_subnet_address" {
  default = ["10.6.3.0/24"]
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