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
| <a name="input_create_express_route_circuit_authorization"></a> [create\_express\_route\_circuit\_authorization](#input\_create\_express\_route\_circuit\_authorization) | Whether to create the Express Route Circuit Authorization resource. Default is false. | `bool` | `true` | no |
| <a name="input_express_route_circuit"></a> [express\_route\_circuit](#input\_express\_route\_circuit) | The Express Route Circuit to create.<br/><br/>    - name: The name of the Express Route Circuit.<br/>    - location: The Azure region where the Express Route Circuit will be created.<br/>    - bandwidth\_in\_mbps: The bandwidth of the circuit in Mbps.<br/>    - peering\_location: The peering location for the circuit.<br/>    - service\_provider\_name: The name of the ExpressRoute service provider.<br/>    - sku\_tier: The SKU tier for the circuit (e.g., Standard, Premium).<br/>    - sku\_family: The SKU family for the circuit (e.g., MeteredData, UnlimitedData).<br/>    - allow\_classic\_operations: Whether classic operations are allowed on this circuit. Default is false. | <pre>object({<br/>    name                     = string<br/>    location                 = string<br/>    bandwidth_in_mbps        = number<br/>    peering_location         = string<br/>    service_provider_name    = string<br/>    sku_tier                 = string<br/>    sku_family               = string<br/>    allow_classic_operations = optional(bool, false)<br/>  })</pre> | `null` | no |
| <a name="input_express_route_circuit_peering"></a> [express\_route\_circuit\_peering](#input\_express\_route\_circuit\_peering) | The Express Route Circuit Peering to create. Circuit name is used if you don't deploy the Express Route Circuit from this module.<br/><br/>    - primary\_peer\_address\_prefix: The primary address prefix for the peering.<br/>    - secondary\_peer\_address\_prefix: The secondary address prefix for the peering.<br/>    - vlan\_id: The VLAN ID for the peering.<br/>    - shared\_key: The shared key for the peering.<br/>    - peer\_asn: The peer ASN for the peering. | <pre>object({<br/>    primary_peer_address_prefix   = string<br/>    secondary_peer_address_prefix = string<br/>    vlan_id                       = number<br/>    shared_key                    = string<br/>    peer_asn                      = number<br/>  })</pre> | `null` | no |
| <a name="input_express_route_gateway"></a> [express\_route\_gateway](#input\_express\_route\_gateway) | The Express Route Gateway to create.<br/><br/>    - name: The name of the Express Route Gateway.<br/>    - scale\_units: The scale units for the gateway.<br/>    - virtual\_hub\_id: The ID of the Virtual Hub to which the gateway will be attached.<br/>    - allow\_non\_virtual\_wan\_traffic: Whether to allow non-virtual WAN traffic. Default is false. | <pre>object({<br/>    name                          = string<br/>    scale_units                   = string<br/>    virtual_hub_id                = string<br/>    allow_non_virtual_wan_traffic = optional(bool, false)<br/>  })</pre> | `null` | no |
| <a name="input_express_route_gateway_connection"></a> [express\_route\_gateway\_connection](#input\_express\_route\_gateway\_connection) | The Express Route Gateway Connection to create. Circuit peering ID is used if you don't deploy the Express Route Circuit from this module.<br/>    If you want to use a keyvault secret for the authorization key, use the resource ID of the keyvault secret.<br/><br/>    - name: The name of the Express Route Gateway Connection.<br/>    - express\_route\_gateway\_id: The ID of the Express Route Gateway.<br/>    - express\_route\_circuit\_peering\_id: The ID of the Express Route Circuit Peering.<br/>    - authorization\_key: The authorization key for the Express Route Gateway Connection. If you want to use a keyvault secret, use the resource ID of the keyvault secret.<br/>    - express\_route\_gateway\_bypass\_enabled: Whether to enable bypass for the Express Route Gateway, default is false.<br/>    - enable\_internet\_security: Whether to enable internet security for the Express Route Gateway Connection, default is false.<br/>    - routing\_weight: The routing weight for the Express Route Gateway Connection, default is 0.<br/>    - routing: Optional routing configuration for the Express Route Gateway Connection.<br/>      - associated\_route\_table\_id: The ID of the associated route table.<br/>      - inbound\_route\_map\_id: The ID of the inbound route map.<br/>      - outbound\_route\_map\_id: The ID of the outbound route map.<br/>      - propagated\_route\_table: Optional propagated route table configuration.<br/>        - labels: List of labels for the propagated route table.<br/>        - route\_table\_ids: List of route table IDs to propagate. | <pre>object({<br/>    name                                 = string<br/>    express_route_gateway_id             = string<br/>    express_route_circuit_peering_id     = string<br/>    authorization_key                    = string<br/>    express_route_gateway_bypass_enabled = optional(bool, false)<br/>    enable_internet_security             = optional(bool, false)<br/>    routing_weight                       = optional(number, 0)<br/>    routing = optional(object({<br/>      associated_route_table_id = optional(string)<br/>      inbound_route_map_id      = optional(string)<br/>      outbound_route_map_id     = optional(string)<br/>      propagated_route_table = optional(object({<br/>        labels          = optional(list(string))<br/>        route_table_ids = list(string)<br/>      }))<br/>    }))<br/>  })</pre> | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the resource. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_express_route_circuit_id"></a> [express\_route\_circuit\_id](#output\_express\_route\_circuit\_id) | The ID of the Express Route Circuit |
| <a name="output_express_route_circuit_name"></a> [express\_route\_circuit\_name](#output\_express\_route\_circuit\_name) | The name of the Express Route Circuit |
| <a name="output_express_route_circuit_peering_id"></a> [express\_route\_circuit\_peering\_id](#output\_express\_route\_circuit\_peering\_id) | The ID of the Express Route Circuit Peering |
| <a name="output_express_route_gateway_id"></a> [express\_route\_gateway\_id](#output\_express\_route\_gateway\_id) | The ID of the Express Route Gateway |
<!-- END_TF_DOCS -->