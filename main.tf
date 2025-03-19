resource "azurerm_express_route_circuit" "this" {
  for_each            = var.express_route_circuit
  name                = each.value.name
  resource_group_name = var.resource_group_name
  location            = var.location

  bandwidth_in_mbps     = each.value.bandwidth_in_mbps
  peering_location      = each.value.peering_location
  service_provider_name = each.value.service_provider_name
  authorization_key     = each.value.authorization_key_name

  sku {
    tier   = each.value.sku_tier
    family = each.value.sku_family
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
  express_route_circuit_name    = azurerm_express_route_circuit.this[0].name
  peering_type                  = "AzurePrivatePeering"
  primary_peer_address_prefix   = each.value.primary_peer_address_prefix
  secondary_peer_address_prefix = each.value.secondary_peer_address_prefix
  vlan_id                       = each.value.vlan_id
  shared_key                    = each.value.shared_key
  peer_asn                      = each.value.peer_asn
}

resource "azurerm_express_route_gateway" "this" {
  for_each            = var.express_route_gateway
  name                = each.value.name
  resource_group_name = var.resource_group_name
  location            = var.location

  scale_units                   = each.value.scale_units
  virtual_hub_id                = each.value.virtual_hub_id
  allow_non_virtual_wan_traffic = each.value.allow_non_virtual_wan_traffic
  tags = merge(
    try(var.tags),
    tomap({
      "Resource Type" = "Express Route Gateway"
    })
  )
}

resource "azurerm_express_route_connection" "this" {
  for_each                         = var.express_route_gateway_connection
  name                             = each.value.name
  express_route_gateway_id         = try(azurerm_express_route_gateway.this[0].id, each.value.er_gateway_id)
  express_route_circuit_peering_id = try(azurerm_express_route_circuit_peering.this[0].id, each.value.circuit_peering_id)
  authorization_key                = each.value.authorization_key
}

