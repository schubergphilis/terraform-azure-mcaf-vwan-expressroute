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

variable "express_route_gateway" {
  description = "The Express Route Gateway to create"
  type = object({
    name                          = string
    scale_units                   = number
    virtual_hub_id                = string
    allow_non_virtual_wan_traffic = optional(bool, false)
  })
}

variable "express_route_circuit" {
  description = "The Express Route Circuit to create"
  type = object({
    name                  = string
    bandwidth_in_mbps     = number
    peering_location      = string
    service_provider_name = string
    sku_tier              = string
    sku_family            = string
  })
}

variable "express_route_circuit_peering" {
  description = "The Express Route Circuit Peering to create"
  type = object({
    enabled                       = optional(bool, false)
    primary_peer_address_prefix   = optional(string)
    secondary_peer_address_prefix = optional(string)
    vlan_id                       = optional(number)
    shared_key                    = optional(string)
    peer_asn                      = optional(number)

  })
}

# variable "resource_group_name" {
#   description = "The name of the resource group in which to create the Express Route Gateway"
#   type        = string
# }

# variable "location" {
#   description = "The location/region to deploy the Express Route Gateway"
#   type        = string
# }

# variable "tags" {
#   description = "A map of tags to assign to the resource."
#   type        = map(string)
#   default     = {}
# }


# variable "express_route_circuit" {
#   description = "The Express Route Circuit to create"
#   type = object({
#     name                   = optional(string)
#     bandwidth_in_mbps      = optional(number)
#     peering_location       = optional(string)
#     service_provider_name  = optional(string)
#     sku_tier               = optional(string)
#     sku_family             = optional(string)
#     authorization_key_name = optional(string)
#   })
# }

# variable "express_route_circuit_peering" {
#   description = "The Express Route Circuit Peering to create. Circuit name is used if you don't deploy the Express Route Circuit from this module"

#   type = object({
#     primary_peer_address_prefix   = optional(string)
#     secondary_peer_address_prefix = optional(string)
#     vlan_id                       = optional(number)
#     shared_key                    = optional(string)
#     peer_asn                      = optional(number)
#   })
# }

# variable "express_route_gateway" {
#   description = "The Express Route Gateway to create"
#   type = object({
#     name                          = optional(string)
#     scale_units                   = optional(number)
#     virtual_hub_id                = optional(string)
#     allow_non_virtual_wan_traffic = optional(bool, true)
#   })
# }
# variable "express_route_gateway_connection" {
#   description = "The Express Route Gateway Connection to create"
#   type = object({
#     name                = optional(string)
#     peering_id          = optional(string)
#     peer_peerings_id    = optional(string)
#     address_prefix_ipv4 = optional(string)
#     authorization_key   = optional(string)
#     er_gateway_id       = optional(string)
#     circuit_peering_id  = optional(string)
#   })
# }
