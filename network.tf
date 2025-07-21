# Creation of Virual Network
resource "azurerm_virtual_network" "vnet" {
  name                = "virtual-Net-1"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]
}

# Creation of Private Network depends on Virtual Network
resource "azurerm_subnet" "subnetVm" {
  name                 = "Subnet-of-1"
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = data.azurerm_resource_group.rg.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Creation of Public ip of Machine
resource "azurerm_public_ip" "pubip" {
  name                = "vm-pubip1"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  allocation_method   = "Static"
  sku                 = "Standard"
  sku_tier            = "Regional"
  ip_version          = "IPv4"
}

# Create Network interface for (NAT) 
resource "azurerm_network_interface" "nic" {

  name                = "network-interface-of-${azurerm_subnet.subnetVm.name}"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "ipconf-1"
    subnet_id                     = azurerm_subnet.subnetVm.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pubip.id
  }
}