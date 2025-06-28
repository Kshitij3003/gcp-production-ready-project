output "cluster_name" {
  value = google_container_cluster.primary.name
}

output "gke_gsa_email" {
  value = google_service_account.gke_gsa.email
}
