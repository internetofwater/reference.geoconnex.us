variable "region" {
  description = "The GCP region"
  type        = string
}

variable "credentials" {
  description = "Path to the GCP credentials file"
  type        = string
}

variable "s3_bucket" {
  description = "GCP bucket"
  type        = string
}
