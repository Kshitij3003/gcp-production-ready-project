resource "google_storage_bucket" "tf_state" {
  name                        = var.bucket_name
  location                    = var.location
  storage_class               = var.storage_class
  force_destroy               = false
  uniform_bucket_level_access = true

  versioning {
    enabled = true
  }
}