resource "azurerm_express_route_circuit" "this" {
  for_each            = var.express_route_circuit
  name                = var.express_route_circuit[each.key].name
  resource_group_name = var.resource_group_name
  location            = var.location

  bandwidth_in_mbps     = var.express_route_circuit[each.key].bandwidth_in_mbps
  peering_location      = var.express_route_circuit[each.key].peering_location
  service_provider_name = var.express_route_circuit[each.key].service_provider_name
  authorization_key     = var.express_route_circuit[each.key].authorization_key_name

  sku {
    tier   = var.express_route_circuit[each.key].sku_tier
    family = var.express_route_circuit[each.key].sku_family
  }

  tags = merge(
    try(var.tags),
    tomap({
      "Resource Type" = "Express Route Circuit"
    })
  )
}


resource "azurerm_express_route_circuit_peering" "this" {
  for_each                      = var.express_route_circuit_peering
  resource_group_name           = var.resource_group_name
  express_route_circuit_name    = azurerm_express_route_circuit.this[each.key].name
  peering_type                  = "AzurePrivatePeering"
  primary_peer_address_prefix   = var.express_route_circuit_peering[each.key].primary_peer_address_prefix
  secondary_peer_address_prefix = var.express_route_circuit_peering[each.key].secondary_peer_address_prefix
  vlan_id                       = var.express_route_circuit_peering[each.key].vlan_id
  shared_key                    = var.express_route_circuit_peering[each.key].shared_key
  peer_asn                      = var.express_route_circuit_peering[each.key].peer_asn
}

resource "azurerm_express_route_gateway" "this" {
  for_each            = var.express_route_gateway
  name                = var.express_route_gateway[each.key].name
  resource_group_name = var.resource_group_name
  location            = var.location

  scale_units                   = var.express_route_gateway[each.key].scale_units
  virtual_hub_id                = var.express_route_gateway[each.key].virtual_hub_id
  allow_non_virtual_wan_traffic = var.express_route_gateway[each.key].allow_non_virtual_wan_traffic
  tags = merge(
    try(var.tags),
    tomap({
      "Resource Type" = "Express Route Gateway"
    })
  )
}

resource "azurerm_express_route_connection" "this" {
  for_each                         = var.express_route_gateway_connection
  name                             = var.express_route_gateway_connection[each.key].name
  express_route_gateway_id         = try(azurerm_express_route_gateway.this[each.key].id, var.express_route_gateway_connection[each.key].er_gateway_id)
  express_route_circuit_peering_id = try(azurerm_express_route_circuit_peering.this[each.key].id, var.express_route_gateway_connection[each.key].circuit_peering_id)
  authorization_key                = var.express_route_gateway_connection[each.key].authorization_key
}

