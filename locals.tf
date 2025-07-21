locals {
  ssh_user          = "Derradji"
  private_key_path  = "C:/Users/Derradji/.ssh/azurekeyssh"

  ssh_connection = {
    type        = "ssh"
    user        = local.ssh_user
    private_key = file(local.private_key_path)
    host        = azurerm_public_ip.pubip.ip_address
  }
}