output "host_project_id" {
  value = google_project.host_project.project_id
}

output "service_project_id" {
  value = google_project.service_project.project_id
}

output "vpc_id" {
  value = google_compute_network.custom_vpc.id
}

output "subnet_name" {
  value = google_compute_subnetwork.subnet_web.name
}