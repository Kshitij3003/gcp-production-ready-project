resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = var.location
  project  = var.project_id
  deletion_protection = false

  release_channel {
    channel = "REGULAR"
  }

  networking_mode = "VPC_NATIVE"
  remove_default_node_pool = true
  initial_node_count       = 1

  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }

  ip_allocation_policy {}
}

resource "google_container_node_pool" "primary_nodes" {
  name       = "${var.cluster_name}-node-pool"
  location   = var.location
  project    = var.project_id
  cluster    = google_container_cluster.primary.name

  node_config {
    machine_type    = "e2-medium"
    service_account = google_service_account.gke_gsa.email

    spot = var.env == "dev" || var.env == "stg" ? true : false  # 🔥 Enables Spot VM mode based on environment

    disk_type = "pd-standard"
    disk_size_gb = 20 

    shielded_instance_config {
      enable_secure_boot          = true
      enable_integrity_monitoring = true
    }

    metadata = {
      disable-legacy-endpoints = "true"
    }

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]

    labels = {
      "env"        = "dev"
      "preemptible" = "true"
    }
  }

  autoscaling {
    min_node_count = 1
    max_node_count = 3
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  initial_node_count = 1
}


# Create GSA
resource "google_service_account" "gke_gsa" {
  account_id   = var.gsa_name
  display_name = "GKE Workload Identity GSA"
  project      = var.project_id
}

# Bind IAM roles (cloudsql.client will be needed later)
resource "google_project_iam_member" "gke_gsa_roles" {
  project = var.project_id
  role    = "roles/iam.workloadIdentityUser"
  member  = "serviceAccount:${var.project_id}.svc.id.goog[${var.k8s_namespace}/${var.ksa_name}]"
}

# Bind GSA ↔️ KSA using annotation (to be done during Kubernetes deployment)
