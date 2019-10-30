resource "azurerm_resource_group" "vNet30_Securus"{
  name="vNet30_Securus"
  location = "North Europe"
}

resource "azurerm_virtual_network" "vNet30_Securus"{
  address_space = ["10.0.30.0/24"]
  name = "vNet30_Securus"
  location = "${azurerm_resource_group.vNet30_Securus.location}"
  resource_group_name = "${azurerm_resource_group.vNet30_Securus.name}"
  dns_servers = ["192.168.1.200","10.0.10.150","10.0.30.200"]
}

resource "azurerm_subnet" "vNET_Front_End_Securus"{
  name = "vNET_Front_End_Securus"
  address_prefix = "10.0.30.0/25"
  resource_group_name = "${azurerm_resource_group.vNet30_Securus.name}"
  virtual_network_name = "${azurerm_virtual_network.vNet30_Securus.name}"
}

resource "azurerm_resource_group" "LRS_Services"{
  name="LRS_Services"
  location="North Europe"
}


resource "azurerm_subnet" "vNet_Back_End_Securus"{
  name = "vNet_Back_End_Securus"
  address_prefix = "10.0.30.128/26"
  resource_group_name = "${azurerm_resource_group.vNet30_Securus.name}"
  virtual_network_name = "${azurerm_virtual_network.vNet30_Securus.name}"
}