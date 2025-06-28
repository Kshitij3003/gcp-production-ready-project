module "vpc" {
  source       = "../../terraform-modules/vpc"
  network_name = var.network_name
  subnet_name  = var.subnet_name
  subnet_cidr  = var.subnet_cidr
  region       = var.region
}

# GKE Module
module "gke" {
  source         = "../../terraform-modules/gke"
  project_id     = var.project_id
  location       = var.location
  cluster_name   = "primary-cluster"
  gsa_name       = "gke-wi-gsa"
  ksa_name       = "gke-workload-identity"
  k8s_namespace  = "default"
  env            = var.env
}

