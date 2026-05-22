# 1. Project Definitions
resource "google_project" "host_project" {
  name            = "Host VPC Project"
  project_id      = var.host_project_id
  org_id          = var.org_id
  billing_account = var.billing_account
}

resource "google_project" "service_project" {
  name            = "Service App Project"
  project_id      = var.service_project_id
  org_id          = var.org_id
  billing_account = var.billing_account
}

# 2. APIs Activation
resource "google_project_service" "host_services" {
  for_each           = toset(["compute.googleapis.com", "dns.googleapis.com"])
  project            = google_project.host_project.project_id
  service            = each.key
  disable_on_destroy = false
}

resource "google_project_service" "service_services" {
  for_each           = toset(["compute.googleapis.com"])
  project            = google_project.service_project.project_id
  service            = each.key
  disable_on_destroy = false
}

# 3. Base Networking (Host Project)
resource "google_compute_network" "custom_vpc" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
  project                 = google_project.host_project.project_id
  depends_on              = [google_project_service.host_services]
}

resource "google_compute_subnetwork" "subnet_web" {
  name          = "subnet-web-${var.region}"
  ip_cidr_range = var.subnet_cidr
  region        = var.region
  network       = google_compute_network.custom_vpc.id
  project       = google_project.host_project.project_id
}

# 4. Shared VPC Links
resource "google_compute_shared_vpc_host_project" "host" {
  project    = google_project.host_project.project_id
  depends_on = [google_project_service.host_services]
}

resource "google_compute_shared_vpc_service_project" "service" {
  host_project    = google_project.host_project.project_id
  service_project = google_project.service_project.project_id

  depends_on = [google_compute_shared_vpc_host_project.host, google_project_service.service_services]
}

# 5. Access Control Permissions
resource "google_compute_subnetwork_iam_member" "subnet_users" {
  project    = google_project.host_project.project_id
  region     = google_compute_subnetwork.subnet_web.region
  subnetwork = google_compute_subnetwork.subnet_web.name
  role       = "roles/compute.networkUser"
  member     = "serviceAccount:${google_project.service_project.number}-compute@developer.gserviceaccount.com"

  depends_on = [google_compute_shared_vpc_service_project.service]
}