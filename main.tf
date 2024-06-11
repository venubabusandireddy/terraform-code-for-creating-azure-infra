terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.87.0"
    }
  }
}

provider "azurerm" {
  features {}    
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
  client_id       = var.client_id
  client_secret   = var.client_secret
}

resource "azurerm_resource_group" "venu" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.virtual_network_name
  address_space       = var.address_space
  location            = azurerm_resource_group.venu.location
  resource_group_name = azurerm_resource_group.venu.name
}

resource "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.venu.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.subnet_address_prefix]
}

resource "azurerm_network_security_group" "sg" {
  name                = var.azurerm_network_security_group_name
  location            = azurerm_resource_group.venu.location
  resource_group_name = azurerm_resource_group.venu.name

  security_rule {
    name                       = "test123"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  
  security_rule {
    name                       = "RDP"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_public_ip" "PIP" {
  name                = "public-ip-vm"
  location            = azurerm_resource_group.venu.location
  resource_group_name = azurerm_resource_group.venu.name
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "nic" {
  name                = var.network_interface_name
  location            = azurerm_resource_group.venu.location
  resource_group_name = azurerm_resource_group.venu.name

  ip_configuration {
    name                          = var.ip_configuration_name
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = var.private_ip_allocation
    public_ip_address_id          = azurerm_public_ip.PIP.id
  }
 }

resource "azurerm_windows_virtual_machine" "vm" {
  name                = var.virtual_machine_name
  location            = azurerm_resource_group.venu.location
  resource_group_name = azurerm_resource_group.venu.name

  network_interface_ids = [azurerm_network_interface.nic.id]

  size = var.virtual_machine_size

  admin_username = var.admin_username
  admin_password = var.admin_password

  os_disk {
    caching              = var.os_disk_caching
    storage_account_type = var.os_disk_storage_account_type
  }

  source_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = var.image_version
  }
}
resource "azurerm_container_registry" "myregistry" {
  name                = var.registry_name
  resource_group_name = azurerm_resource_group.venu.name
  location            = azurerm_resource_group.venu.location
  sku                 = "Premium"
}
resource "azurerm_kubernetes_cluster" "akc" {
  name                = var.cluster_name
  location            = azurerm_resource_group.venu.location
  resource_group_name = azurerm_resource_group.venu.name
  dns_prefix          = var.dns_prefix

  default_node_pool {
    name            = "default"
    node_count      = var.node_count
    vm_size         = var.vm_size
    type            = "VirtualMachineScaleSets"
    os_disk_size_gb = var.os_disk_size_gb
   
  }

  service_principal {
    client_id     = var.client_id
    client_secret = var.client_secret
  }

  tags = var.tags
}

 