resource "azurerm_network_interface" "example_nic" {
  name                = "${var.application_type}-${var.resource_type}-nic"
  location            = var.location
  resource_group_name = var.resource_group

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.public_ip_address_id
  }
}

resource "azurerm_linux_virtual_machine" "example_vm" {
  name                = "${var.application_type}-${var.resource_type}"
  location            = var.location
  resource_group_name = var.resource_group
  size                = "Standard_DS2_v2"
  admin_username      = var.vm_admin_username
  network_interface_ids = [azurerm_network_interface.example_nic.id]
  source_image_id       = var.packer_image
  admin_ssh_key {
    username   = var.vm_admin_username
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDWG2Gems0ivdh8ItxBZnbWw1G15ZxDokDL1T/9aZrkrEQK5gFkOk2AajENyqUsvV+Y9IPeece/jHjRUqYPcqmRZw8g5+O7QgNzRInBTFgpbYDXyEtbKNtORt2LyXdkSBoLm0vzcmPPt/EcQWSByfOn1LAU2kQOAnx3/+M+zB2Y8Hst6rKz/lBhusTVa5A8ZUB2hOLfQedLDSq1NMmzP+zKQ2czcv/DIZ34uC3EBmEgfXFAIE75SmYv0I99s3sqhkXnss7BgN0SeOHxXhhMKLrVHNT6u5Szn4WQEOrLDLyFuYOTyReLzFXvANvFc/38g4y4259L2JXrgJnT463sdqn9xLhLfmq597OLGgI92rZ3MrzMTkrc4uR9BA40ihVT0oEWoaZ7UcFgAgZYYi9N/taK1nNS6HQ1VCK6gAwdXKww1enVifOl25TJYvnpEaPYONACBuoSyBy5+bQ+CKx3RRaZ3Uuq1gJByHRpB3m495iLxklYqXmmDN4rcwIq0moERhs= azuread\\cyrinesassi@DESKTOP-8M25SKJ"
  }
  os_disk {
    caching           = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
#   source_image_reference {
#     publisher = "Canonical"
#     offer     = "UbuntuServer"
#     sku       = "18.04-LTS"
#     version   = "latest"
#   }
}
