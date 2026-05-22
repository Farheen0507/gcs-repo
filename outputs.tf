output "deployed_host_project_id" {
  value       = module.shared_network.host_project_id
  description = "The project ID of the Shared VPC Host"
}

output "deployed_service_project_id" {
  value       = module.shared_network.service_project_id
  description = "The project ID of the attached Service project"
}

output "deployed_vpc_id" {
  value       = module.shared_network.vpc_id
  description = "The URI of the created Shared VPC"
}

output "deployed_subnet_name" {
  value       = module.shared_network.subnet_name
  description = "The name of the created subnet"
}