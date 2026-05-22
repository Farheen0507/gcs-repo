module "shared_network" {
  source = "./modules/shared_vpc"

  org_id             = var.org_id
  billing_account    = var.billing_account
  host_project_id    = var.host_project_id
  service_project_id = var.service_project_id
  region             = var.region
  vpc_name           = var.vpc_name
  subnet_cidr        = var.subnet_cidr
}