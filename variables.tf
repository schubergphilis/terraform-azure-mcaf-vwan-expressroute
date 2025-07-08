variable "resource_group_name" {
  description = "The name of the resource group in which to create the Express Route Gateway"
  type        = string
}

variable "location" {
  description = "The location/region to deploy the Express Route Gateway"
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the resource."
  type        = map(string)
  default     = {}
}

variable "express_route_circuit" {
  description = "The Express Route Circuit to create"
  type = object({
    name                     = string
    location                 = string
    bandwidth_in_mbps        = number
    peering_location         = string
    service_provider_name    = string
    sku_tier                 = string
    sku_family               = string
    allow_classic_operations = optional(bool, false)
  })
  default = null
}

variable "create_express_route_circuit_authorization" {
  description = "Whether to create the Express Route Circuit Authorization resource. Default is false."
  type        = bool
  default     = true
}

variable "express_route_circuit_peering" {
  description = "The Express Route Circuit Peering to create. Circuit name is used if you don't deploy the Express Route Circuit from this module"
  type = object({
    primary_peer_address_prefix   = string
    secondary_peer_address_prefix = string
    vlan_id                       = number
    shared_key                    = string
    peer_asn                      = number
  })
  default = null
}

variable "express_route_gateway" {
  description = "The Express Route Gateway to create"
  type = object({
    name                          = string
    scale_units                   = string
    virtual_hub_id                = string
    allow_non_virtual_wan_traffic = optional(bool, false)
  })
  default = null
}

variable "express_route_gateway_connection" {
  type = object({
    name                                 = string
    express_route_gateway_id             = string
    express_route_circuit_peering_id     = string
    authorization_key                    = string
    express_route_gateway_bypass_enabled = optional(bool, false)
    enable_internet_security             = optional(bool, false)
    routing_weight                       = optional(number, 0)
    routing = optional(object({
      associated_route_table_id = optional(string)
      inbound_route_map_id      = optional(string)
      outbound_route_map_id     = optional(string)
      propagated_route_table = optional(object({
        labels          = optional(list(string))
        route_table_ids = list(string)
      }))
    }))
  })
  default = null
  description = <<DESCRIPTION
    The Express Route Gateway Connection to create. Circuit peering ID is used if you don't deploy the Express Route Circuit from this module.
    If you want to use a keyvault secret for the authorization key, use the resource ID of the keyvault secret.

    - name: The name of the Express Route Gateway Connection.
    - express_route_gateway_id: The ID of the Express Route Gateway.
    - express_route_circuit_peering_id: The ID of the Express Route Circuit Peering.
    - authorization_key: The authorization key for the Express Route Gateway Connection. If you want to use a keyvault secret, use the resource ID of the keyvault secret.
    - express_route_gateway_bypass_enabled: Whether to enable bypass for the Express Route Gateway, default is false.
    - enable_internet_security: Whether to enable internet security for the Express Route Gateway Connection, default is false.
    - routing_weight: The routing weight for the Express Route Gateway Connection, default is 0.
    - routing: Optional routing configuration for the Express Route Gateway Connection.
      - associated_route_table_id: The ID of the associated route table.
      - inbound_route_map_id: The ID of the inbound route map.
      - outbound_route_map_id: The ID of the outbound route map.
      - propagated_route_table: Optional propagated route table configuration.
        - labels: List of labels for the propagated route table.
        - route_table_ids: List of route table IDs to propagate.
  DESCRIPTION
}

