resource "azurerm_resource_group" "lrs_service_production"{
  name = "lrs_service_production"
  location = "North Europe"
}

resource "azurerm_storage_account" "lrs_Production"{
  name = "lrs_Production"
  resource_group_name = "${azurerm_resource_group.lrs_service_production.name}"
  account_kind = "Storage"
  location ="${azurerm_resource_group.lrs_service_production.location}"
  account_tier = "Standard"
  account_replication_type = "LRS"
}