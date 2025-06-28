resource "google_sql_database_instance" "default" {
  name             = var.db_instance_name
  database_version = var.db_version
  region           = var.region
  project          = var.project_id

  settings {
    tier = var.tier # db-f1-micro, db-custom-1-3840, etc.

    ip_configuration {
      ipv4_enabled    = false
      private_network = var.vpc_network_self_link
      enable_private_path_for_google_cloud_services = true
      require_ssl     = true
      authorized_networks = []
    }

    backup_configuration {
      enabled = true
    }

    database_flags {
      name  = "cloudsql.iam_authentication"
      value = "on"
    }
  }

  deletion_protection = false
}

resource "google_sql_user" "iam_user" {
  name     = var.gsa_email   # Same as GSA used in GKE
  instance = google_sql_database_instance.default.name
  type     = "CLOUD_IAM_USER"
}

resource "google_sql_database" "default" {
  name     = var.db_name
  instance = google_sql_database_instance.default.name
}

# IAM Bindings
resource "google_project_iam_member" "cloudsql_client" {
  project = var.project_id
  role    = "roles/cloudsql.client"
  member  = "serviceAccount:${var.gsa_email}"
}

resource "google_project_iam_member" "cloudsql_user" {
  project = var.project_id
  role    = "roles/cloudsql.instanceUser"
  member  = "serviceAccount:${var.gsa_email}"
}
