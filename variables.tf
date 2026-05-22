variable "org_id" {
  type        = string
  description = "The GCP Organization ID"
}

variable "billing_account" {
  type        = string
  description = "The GCP Billing Account ID"
}

variable "host_project_id" {
  type        = string
  description = "The ID to use for the Host Project"
}

variable "service_project_id" {
  type        = string
  description = "The ID to use for the Service Project"
}

variable "region" {
  type        = string
  default     = "us-central1"
  description = "The region for the subnets"
}

variable "vpc_name" {
  type        = string
  default     = "enterprise-shared-vpc"
  description = "Name of the Shared VPC network"
}

variable "subnet_cidr" {
  type        = string
  default     = "10.0.1.0/24"
  description = "CIDR range for the application subnet"
}