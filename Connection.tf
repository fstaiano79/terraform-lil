provider "azurerm" {
  subscription_id = "${var.SUBSCRIPTION_ID}"
  client_id = "${var.CLIENT_ID}"
  client_secret = "${var.CLIENT_SECRET}"
  tenant_id = "${var.TENANT_ID}"
}

variable "SUBSCRIPTION_ID" {}
variable "CLIENT_ID" {}
variable "CLIENT_SECRET" {}
variable "TENANT_ID" {}