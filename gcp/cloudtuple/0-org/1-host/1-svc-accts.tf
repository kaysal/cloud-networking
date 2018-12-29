# vm service account
#-----------------------------------------------
resource "google_service_account" "vm_host_project" {
  account_id   = "compute-engine"
  display_name = "GCE Service Account"
  project = "${google_project.host_project.name}"
}

# terraform service accounts
#----------------------------------------------------
resource "google_service_account" "tf_host_project" {
  account_id   = "terraform"
  display_name = "Terraform Service Account"
  project = "${google_project.host_project.name}"
}
