output "project_id" {
  value = var.project_id
}

output "region" {
  value = var.region
}

output "cluster_name" {
  value = module.gke.cluster_name
}

output "gke_gsa_email" {
  value = module.gke.gke_gsa_email
}
