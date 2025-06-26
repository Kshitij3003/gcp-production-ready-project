terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

resource "random_id" "suffix" {
  byte_length = 4
}

resource "google_storage_bucket" "tf_state" {
  name          = "gke-project-tfstate-${random_id.suffix.hex}"
  location      = var.region
  force_destroy = false
  uniform_bucket_level_access = true
  versioning {
    enabled = true
  }
}

output "bucket_name" {
  value = google_storage_bucket.tf_state.name
}
