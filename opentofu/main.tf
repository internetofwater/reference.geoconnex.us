locals {
  credentials  = file(var.credentials)
  data         = jsondecode(local.credentials)
}

provider "google" {
  region              = var.region
  credentials         = local.credentials
  project             = local.data.project_id
}

resource "google_sql_database_instance" "postgres" {
  name             = "geoconnex-reference-features"
  database_version = "POSTGRES_14"

  settings {
    tier            = "db-g1-small"
    disk_autoresize = false

    ip_configuration {
      ipv4_enabled = true
    }

    database_flags {
      name  = "cloudsql.enable_pg_cron"
      value = "on"
    }
  }

  deletion_protection = true
}

resource "google_sql_database" "reference" {
  name     = "reference"
  instance = google_sql_database_instance.postgres.name
}

resource "google_project_iam_binding" "cloudsql_admin" {
  project = local.data.project_id
  role    = "roles/cloudsql.admin"

  members = [
    "serviceAccount:${local.data.client_email}"
  ]
}

resource "google_storage_bucket" "harvest_bucket" {
  name          = var.s3_bucket
  location      = var.region
  
  storage_class = "STANDARD"
  uniform_bucket_level_access = true

  versioning {
    enabled = false
  }
}

resource "google_storage_bucket_iam_member" "bucket_access" {
  bucket = google_storage_bucket.harvest_bucket.name
  role   = "roles/storage.objectAdmin"
  member = "serviceAccount:${local.data.client_email}"
}

resource "google_storage_hmac_key" "hmac_key" {
  service_account_email = local.data.client_email
}
