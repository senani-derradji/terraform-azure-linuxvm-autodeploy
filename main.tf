data "azurerm_resource_group" "rg" {
  name = var.SBResource
}

# Creation of Linux Virtual Machine ...
resource "azurerm_linux_virtual_machine" "linuxvm" {
  name = "LinuxUbuntu-WebServer"
  size = "Standard_DS1_v2"

  resource_group_name             = data.azurerm_resource_group.rg.name
  location                        = data.azurerm_resource_group.rg.location
  admin_username                  = local.ssh_connection.user
  disable_password_authentication = true
  network_interface_ids           = [azurerm_network_interface.nic.id]

  admin_ssh_key {
    username   = local.ssh_connection.user
    public_key = file("C:/Users/Derradji/.ssh/azurekeyssh.pub")
  }

  os_disk {
    name                 = "OSDisk-${var.SBResource}"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  # Image of VirtualMachine Linux Ubuntu
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  # File Uploaded Excution ...
  provisioner "file" {
    source      = "./Excutable-Files/basics.sh"
    destination = "/home/${local.ssh_connection.user}/basics.sh"

    connection {
      type        = local.ssh_connection.type
      user        = local.ssh_connection.user
      private_key = local.ssh_connection.private_key
      host        = local.ssh_connection.host
    }
  }

  # Run The Script.sh
  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/${local.ssh_connection.user}/basics.sh",
      "sudo bash /home/${local.ssh_connection.user}/basics.sh"
    ]
    connection {
      type        = local.ssh_connection.type
      user        = local.ssh_connection.user
      private_key = local.ssh_connection.private_key
      host        = local.ssh_connection.host
    }

  }
}