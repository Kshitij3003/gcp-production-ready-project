provider "google" {
  project = var.project_id
  region  = var.region
}

module "vpc" {
  source       = "../../../terraform-modules/vpc"
  network_name = var.network_name
  subnet_name  = var.subnet_name
  subnet_cidr  = var.subnet_cidr
  region       = var.region
}