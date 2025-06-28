project_id   = "devops-project-458912"
region       = "us-central1"

# VPC module vars
network_name = "vpc-main"
subnet_name  = "subnet-main"
subnet_cidr  = "10.10.0.0/16"

# GKE module vars
cluster_name     = "primary-cluster"
gsa_name         = "gke-wi-gsa"
ksa_name         = "gke-workload-identity"
k8s_namespace    = "default"
location         = "us-central1-a"
env              = "dev"