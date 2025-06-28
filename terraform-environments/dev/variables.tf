variable "project_id" {
  description = "The GCP project ID"
  type        = string
  default     = "devops-project-458912"
}

variable "region" {
  description = "The default region for resources"
  type        = string
  default     = "us-central1"
}


#VPC Varaibles

variable "network_name" {
  type        = string
  description = "Name of the VPC network"
}

variable "subnet_name" {
  type        = string
  description = "Name of the subnet"
}

variable "subnet_cidr" {
  type        = string
  description = "CIDR range of the subnet"
}

# GKE Varaibles

variable "cluster_name" {
  type = string
}

variable "gsa_name" {
  type        = string
  description = "Google service account for Workload Identity"
}

variable "ksa_name" {
  type        = string
  description = "Kubernetes service account name"
}

variable "k8s_namespace" {
  type        = string
  description = "Kubernetes namespace"
}

variable "location" {
  type = string
}

variable "env" {
  type = string
}
