# terraform-azure-mcaf-vwan-expressroute
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.9 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_express_route_circuit.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/express_route_circuit) | resource |
| [azurerm_express_route_circuit_authorization.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/express_route_circuit_authorization) | resource |
| [azurerm_express_route_circuit_peering.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/express_route_circuit_peering) | resource |
| [azurerm_express_route_connection.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/express_route_connection) | resource |
| [azurerm_express_route_gateway.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/express_route_gateway) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_location"></a> [location](#input\_location) | The location/region to deploy the Express Route Gateway | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which to create the Express Route Gateway | `string` | n/a | yes |
| <a name="input_express_route_circuit"></a> [express\_route\_circuit](#input\_express\_route\_circuit) | The Express Route Circuit to create | <pre>object({<br/>    name                     = string<br/>    location                 = string<br/>    bandwidth_in_mbps        = number<br/>    peering_location         = string<br/>    service_provider_name    = string<br/>    sku_tier                 = string<br/>    sku_family               = string<br/>    allow_classic_operations = optional(bool, false)<br/>  })</pre> | `null` | no |
| <a name="input_express_route_circuit_peering"></a> [express\_route\_circuit\_peering](#input\_express\_route\_circuit\_peering) | The Express Route Circuit Peering to create. Circuit name is used if you don't deploy the Express Route Circuit from this module | <pre>object({<br/>    primary_peer_address_prefix   = string<br/>    secondary_peer_address_prefix = string<br/>    vlan_id                       = number<br/>    shared_key                    = string<br/>    peer_asn                      = number<br/>  })</pre> | `null` | no |
| <a name="input_express_route_gateway"></a> [express\_route\_gateway](#input\_express\_route\_gateway) | The Express Route Gateway to create | <pre>object({<br/>    name                          = string<br/>    scale_units                   = string<br/>    virtual_hub_id                = string<br/>    allow_non_virtual_wan_traffic = optional(bool, false)<br/>  })</pre> | `null` | no |
| <a name="input_express_route_gateway_connection"></a> [express\_route\_gateway\_connection](#input\_express\_route\_gateway\_connection) | The Express Route Gateway Connection to create | <pre>object({<br/>    name                                 = string<br/>    express_route_gateway_id             = string<br/>    express_route_circuit_peering_id     = string<br/>    authorization_key                    = string<br/>    express_route_gateway_bypass_enabled = optional(bool, false)<br/>    enable_internet_security             = optional(bool, false)<br/>    routing_weight                       = optional(number, 0)<br/>    routing = optional(object({<br/>      associated_route_table_id = optional(string)<br/>      inbound_route_map_id      = optional(string)<br/>      outbound_route_map_id     = optional(string)<br/>      propagated_route_table = optional(object({<br/>        labels          = optional(list(string))<br/>        route_table_ids = list(string)<br/>      }))<br/>    }))<br/>  })</pre> | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the resource. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_express_route_circuit_id"></a> [express\_route\_circuit\_id](#output\_express\_route\_circuit\_id) | The ID of the Express Route Circuit |
| <a name="output_express_route_circuit_name"></a> [express\_route\_circuit\_name](#output\_express\_route\_circuit\_name) | The name of the Express Route Circuit |
| <a name="output_express_route_circuit_peering_id"></a> [express\_route\_circuit\_peering\_id](#output\_express\_route\_circuit\_peering\_id) | The ID of the Express Route Circuit Peering |
| <a name="output_express_route_gateway_id"></a> [express\_route\_gateway\_id](#output\_express\_route\_gateway\_id) | The ID of the Express Route Gateway |
<!-- END_TF_DOCS -->