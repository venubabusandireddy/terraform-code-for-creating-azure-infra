variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
}

variable "tenant_id" {
  description = "Azure tenant ID"
  type        = string
}

variable "client_id" {
  description = "Azure client ID"
  type        = string
}

variable "client_secret" {
  description = "Azure client secret"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  type        = string
}

variable "location" {
  description = "Azure region where the resources will be created"
  type        = string
}

variable "virtual_network_name" {
  description = "Name of the Azure Virtual Network"
  type        = string
}

variable "address_space" {
  description = "Address space for the Virtual Network"
  type        = list(string)
}

variable "subnet_name" {
  description = "Name of the Azure Subnet"
  type        = string
}

variable "subnet_address_prefix" {
  description = "Address prefix for the Subnet"
  type        = string
}

variable "azurerm_network_security_group_name" {
  description = "Name of the Azure Network Security Group"
  type        = string
  default     = "nsg02"
}

variable "network_interface_name" {
  description = "Name of the Azure Network Interface"
  type        = string
}

variable "ip_configuration_name" {
  description = "Name of the IP Configuration"
  type        = string
}

variable "private_ip_allocation" {
  description = "Private IP address allocation method"
  type        = string
}

variable "virtual_machine_name" {
  description = "Name of the Azure Virtual Machine"
  type        = string
}

variable "virtual_machine_size" {
  description = "Size of the Virtual Machine"
  type        = string
}

variable "admin_username" {
  description = "Username for the Virtual Machine"
  type        = string
}

variable "admin_password" {
  description = "Password for the Virtual Machine"
  type        = string
}

variable "os_disk_caching" {
  description = "Caching type for the OS disk"
  type        = string
}

variable "os_disk_storage_account_type" {
  description = "Storage account type for the OS disk"
  type        = string
}

variable "image_publisher" {
  description = "Publisher of the OS image"
  type        = string
}

variable "image_offer" {
  description = "Offer of the OS image"
  type        = string
}

variable "image_sku" {
  description = "SKU of the OS image"
  type        = string
}

variable "image_version" {
  description = "Version of the OS image"
  type        = string
}

variable "cluster_name" {
  description = "The name of the AKS cluster."
}

variable "dns_prefix" {
  description = "The DNS prefix for the AKS cluster."
}

variable "node_count" {
  description = "The number of nodes in the AKS cluster."
}

variable "vm_size" {
  description = "The size of the Virtual Machines in the AKS cluster."
}

variable "os_disk_size_gb" {
  description = "The size of the OS disk in gigabytes."
}

variable "os_type" {
  description = "The type of OS to use for the Virtual Machines in the AKS cluster."
}

variable "tags" {
  description = "A map of tags to assign to the resources."
  type        = map(string)
}

variable "registry_name" {
  description = "this is the name pf container registry"
}
