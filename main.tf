resource "azurerm_express_route_circuit" "this" {
  count               = var.express_route_circuit != null ? 1 : 0
  name                = var.express_route_circuit.name
  resource_group_name = var.resource_group_name
  location            = try(var.express_route_circuit.location, var.location)

  bandwidth_in_mbps     = var.express_route_circuit.bandwidth_in_mbps
  peering_location      = var.express_route_circuit.peering_location
  service_provider_name = var.express_route_circuit.service_provider_name

  sku {
    tier   = var.express_route_circuit.sku_tier
    family = var.express_route_circuit.sku_family
  }

  tags = merge(
    try(var.tags),
    tomap({
      "Resource Type" = "Express Route Circuit"
    })
  )
}

resource "azurerm_express_route_circuit_authorization" "this" {
  count                      = var.express_route_circuit != null ? 1 : 0
  name                       = "${var.express_route_circuit.name}-key"
  resource_group_name        = var.resource_group_name
  express_route_circuit_name = azurerm_express_route_circuit.this[0].name
}

resource "azurerm_express_route_circuit_peering" "this" {
  count                         = var.express_route_circuit_peering != null ? 1 : 0
  resource_group_name           = var.resource_group_name
  express_route_circuit_name    = azurerm_express_route_circuit.this[0].name
  peering_type                  = "AzurePrivatePeering"
  primary_peer_address_prefix   = var.express_route_circuit_peering.primary_peer_address_prefix
  secondary_peer_address_prefix = var.express_route_circuit_peering.secondary_peer_address_prefix
  vlan_id                       = var.express_route_circuit_peering.vlan_id
  shared_key                    = var.express_route_circuit_peering.shared_key
  peer_asn                      = var.express_route_circuit_peering.peer_asn
}

resource "azurerm_express_route_gateway" "this" {
  count               = var.express_route_gateway != null ? 1 : 0
  name                = var.express_route_gateway.name
  resource_group_name = var.resource_group_name
  location            = var.location

  scale_units                   = var.express_route_gateway.scale_units
  virtual_hub_id                = var.express_route_gateway.virtual_hub_id
  allow_non_virtual_wan_traffic = var.express_route_gateway.allow_non_virtual_wan_traffic
  tags = merge(
    try(var.tags),
    tomap({
      "Resource Type" = "Express Route Gateway"
    })
  )
}

resource "azurerm_express_route_connection" "this" {
  count                            = var.express_route_gateway_connection != null ? 1 : 0
  name                             = var.express_route_gateway_connection.name
  express_route_gateway_id         = try(azurerm_express_route_gateway.this[0].id, var.express_route_gateway_connection.er_gateway_id)
  express_route_circuit_peering_id = try(azurerm_express_route_circuit_peering.this[0].id, var.express_route_circuit_peering.circuit_peering_id)
  authorization_key                = var.express_route_gateway_connection.authorization_key
}

