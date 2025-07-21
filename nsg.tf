# Create Net Sec Group Rule to Allow Traffic on port 22 (SSH) , 3389 (RDP) etc ...
resource "azurerm_network_security_group" "nsg" {

  name                = "Net-Sec-Group1"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location

  # Security Rule To Allow Traffics on Port 22 using TCP protocol
  security_rule {
    name                       = "ssh22allow"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  # Allow Traffics on Port 3389 (RDP)
  security_rule {
    name                   = "rdp3389allow"
    priority               = 1001
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "3389"
    source_address_prefix  = "*"
    destination_address_prefix            = "*"
  }
}

# Link NIC with Network Security Group Rule
resource "azurerm_network_interface_security_group_association" "nsg_assoc" {
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}