resource "azurerm_resource_group" "vNet30_Securus"{
  name="vNet30_Securus"
  location = "North Europe"
}

resource "azurerm_virtual_network" "vNet30_Securus"{
  address_space = ["10.0.30.0/24"]
  name = "vNet30_Securus"
  location = "${azurerm_resource_group.vNet30_Securus.location}"
  resource_group_name = "${azurerm_resource_group.vNet30_Securus.name}"
}