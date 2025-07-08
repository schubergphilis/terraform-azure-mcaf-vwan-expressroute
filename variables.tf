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
  description = "The Express Route Gateway Connection to create"
  type = object({
    name                             = string
    express_route_gateway_id         = string
    express_route_circuit_peering_id = string
    authorization_key                = string
  })
  default = null
}
