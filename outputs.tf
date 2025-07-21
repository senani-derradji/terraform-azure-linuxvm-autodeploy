output "PublicIPADD" {
  value       = "${azurerm_linux_virtual_machine.linuxvm.name} : ${azurerm_public_ip.pubip.ip_address}"
  sensitive   = false
  description = "the public ip address of Virtual Machine"
}