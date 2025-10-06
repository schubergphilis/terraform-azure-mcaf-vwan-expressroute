output "express_route_circuit_name" {
  description = "The name of the Express Route Circuit"
  value       = length(azurerm_express_route_circuit.this) > 0 ? azurerm_express_route_circuit.this[0].name : null
}

output "express_route_circuit_id" {
  description = "The ID of the Express Route Circuit"
  value       = length(azurerm_express_route_circuit.this) > 0 ? azurerm_express_route_circuit.this[0].id : null
}

output "express_route_circuit_peering_id" {
  description = "The ID of the Express Route Circuit Peering"
  value       = length(azurerm_express_route_circuit_peering.this) > 0 ? azurerm_express_route_circuit_peering.this[0].id : null
}

output "express_route_gateway_id" {
  description = "The ID of the Express Route Gateway"
  value       = length(azurerm_express_route_gateway.this) > 0 ? azurerm_express_route_gateway.this[0].id : null
}
