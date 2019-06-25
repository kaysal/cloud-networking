# vm service account
#-----------------------------------------------
resource "google_service_account" "vm_host_project" {
  account_id   = "gce-sa"
  display_name = "GCE Service Account"
  project      = google_project.host_project.name
}

