resource "azurerm_resource_group" "this" {
  count    = true ? 1 : 0
  name     = "example-resource-group"
  location = "West Europe"
  tags = {
    "Environment"   = "Development"
    "Project"       = "ExampleProject"
    "Resource Type" = "Resource Group"
  }
}

resource "azurerm_express_route_gateway" "this" {
  name                = "example-express-route-gateway"
  resource_group_name = "example-resource-group"
  location            = "West Europe"

  scale_units                   = 2
  virtual_hub_id                = "/subscriptions/your-subscription-id/resourceGroups/example-resource-group/providers/Microsoft.Network/virtualHubs/example-virtual-hub"
  allow_non_virtual_wan_traffic = true
  tags = {
    "Environment"   = "Development"
    "Project"       = "ExampleProject"
    "Resource Type" = "Express Route Gateway"
  }
}

resource "azurerm_express_route_circuit" "this" {
  name                = "example-express-route-circuit"
  resource_group_name = "example-resource-group"
  location            = "West Europe"

  bandwidth_in_mbps     = 1000
  peering_location      = "London"
  service_provider_name = "ExampleServiceProvider"

  sku {
    tier   = "Standard"
    family = "MeteredData"
  }

  tags = {
    "Environment"   = "Development"
    "Project"       = "ExampleProject"
    "Resource Type" = "Express Route Circuit"
  }
}

resource "azurerm_express_route_circuit_peering" "this" {
  count                         = true ? 1 : 0
  resource_group_name           = "example-resource-group"
  express_route_circuit_name    = azurerm_express_route_circuit.this.name
  peering_type                  = "AzurePrivatePeering"
  primary_peer_address_prefix   = "10.0.0.0/30"
  secondary_peer_address_prefix = "10.0.1.0/30"
  vlan_id                       = 200
  shared_key                    = "Super Secret Key"
  peer_asn                      = 65001
}
