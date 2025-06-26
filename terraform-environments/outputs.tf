output "project_id" {
  value = var.project_id
}

output "region" {
  value = var.region
}

output "bucket_name" {
  description = "The name of the bucket"
  value       = google_storage_bucket.tf_state.name
}
