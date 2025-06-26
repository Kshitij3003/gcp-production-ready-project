variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The default region for resources"
  type        = string
}

variable "bucket_name" {
  description = "Name of the GCS bucket to store remote state"
  type        = string
}

variable "location" {
  description = "GCS bucket location"
  type        = string
  default     = "ASIA"
}

variable "storage_class" {
  description = "Storage class of the bucket"
  type        = string
  default     = "STANDARD"
}
