variable "project_id" {
  type = string
}

variable "location" {
  type = string
}

variable "env" {
  type = string
}

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
