
provider "azurerm" {
  features {}
  client_id       = "1df7c764-c465-4cb0-ba13-2c8537ff4e40"
  client_secret   = "j_Y8Q~yDkyBmEh7-KJNh8Grl~U98QcREnkyczc8-"
  tenant_id       = "6e5333d4-3d6b-47fe-ae35-423b18a0d84e"
  subscription_id = "33e2cd81-bd55-4a26-bb23-6b169e51135f"
}

resource "azurerm_resource_group" "rg" {
  name     = var.rg-name
  location = var.loc-name
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet-name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = var.ipdaddress
}

resource "azurerm_subnet" "subnet" {
  name                 = var.subnet-name
  resource_group_name  = azurerm_resource_group.rg.name
  address_prefixes     = var.subaddress
  virtual_network_name = azurerm_virtual_network.vnet.name
}

resource "azurerm_virtual_network" "vnet2" {
  name                = var.vnet2-name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = var.ipaddress2
}

resource "azurerm_subnet" "subnet2" {
  name                 = var.sunbetname2
  virtual_network_name = azurerm_virtual_network.vnet2.name
  resource_group_name  = azurerm_resource_group.rg.name
  address_prefixes     = var.subaddress2
}
#PEERING
resource "azurerm_virtual_network_peering" "peer1" {
  name = "peer1to2"
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name = azurerm_resource_group.rg.name
  remote_virtual_network_id = azurerm_virtual_network.vnet2.id
}

resource "azurerm_virtual_network_peering" "peer2" {
  name = "peer2to1"
  virtual_network_name = azurerm_virtual_network.vnet2.name
  resource_group_name = azurerm_resource_group.rg.name
  remote_virtual_network_id = azurerm_virtual_network.vnet.id
}
