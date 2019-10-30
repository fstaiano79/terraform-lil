resource "azurerm_resource_group" "LRS-Production"{
  name = "LRS-Production"
  location = "North Europe"
}

resource "azurerm_storage_account" "lrsproduction"{
  name = "lrsproduction"
  resource_group_name = "${azurerm_resource_group.LRS-Production.name}"
  account_kind = "Storage"
  location ="${azurerm_resource_group.LRS-Production.location}"
  account_tier = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "LRS-AZU-01" {
   name = "vhds"
   resource_group_name = "${azurerm_resource_group.LRS-Production.name}"
   storage_account_name = "${azurerm_storage_account.lrsproduction.name}"
   container_access_type= "private"
}

resource "azurerm_network_interface" "LRSPRODNIC"{
  name = "lrsprodnic"
  location="${azurerm_resource_group.LRS-Production.location}"
  resource_group_name = "${azurerm_resource_group.LRS-Production.name}"
  ip_configuration {
    name = "lrsprodnic"
    private_ip_address_allocation = "static"
    subnet_id = "${azurerm_subnet.vNET_Front_End_Securus.id}"
    }

}

resource "azurerm_virtual_machine" "LRS-AZU-01"{
  resource_group_name = "${azurerm_resource_group.LRS-Production.name}"
  name = "LRS-AZU-01"
  vm_size = "Standard_A2_v2"
  location="${azurerm_resource_group.LRS-Production.location}"
  network_interface_ids = ["${azurerm_network_interface.LRSPRODNIC.id}"]

  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer = "WindowsServer"
    sku = "2016-Datacenter"
    version = "latest"
     }
  storage_os_disk {
    create_option = "FromImage"
    name = "LRS-AZU-01-OS"
    caching = "ReadWrite"
    disk_size_gb = "127"
    vhd_uri = "${azurerm_storage_account.lrsproduction.primary_blob_endpoint}${azurerm_storage_container.LRS-AZU-01.name}/LRS-AZU-01-OS.vhd"

  }
  os_profile {
    admin_username = "azmin"
    computer_name = "LRS-AZU-01"
    admin_password = "@Azminsecurity1"
  }
}