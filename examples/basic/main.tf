terraform {
  required_version = "~> 1.9"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

module "expressroute" {
  source              = "../.."
  resource_group_name = "rg-example"
  location            = "westeurope"

  express_route_circuit = {
    name                     = "example-name"
    location                 = "westeurope"
    bandwidth_in_mbps        = 1000
    peering_location         = "Frankfurt"
    service_provider_name    = "Equinix"
    sku_tier                 = "Standard"
    sku_family               = "MeteredData"
    allow_classic_operations = false
  }
  express_route_circuit_peering = {
    primary_peer_address_prefix   = "1.1.1.1"
    secondary_peer_address_prefix = "1.1.1.2"
    vlan_id                       = 200
    shared_key                    = "Resource ID of the keyvault secret"
    peer_asn                      = 64515
  }
  express_route_gateway = {
    name                          = "example-name"
    scale_units                   = "2"
    virtual_hub_id                = "Resource ID of the Virtual HUB"
    allow_non_virtual_wan_traffic = false
  }
  express_route_gateway_connection = {
    name                                 = "example-name"
    er_gateway_id                        = "Resource ID of the Express Route gateway"
    circuit_peering_id                   = "Resource ID of the circuit peering"
    authorization_key_keyvault_secret_id = "Resource ID of the keyvault secret"
  }
}