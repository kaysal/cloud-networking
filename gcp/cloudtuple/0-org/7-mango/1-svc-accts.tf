
# vm service account
#-----------------------------------------------
resource "google_service_account" "vm_mango_service_project" {
  account_id   = "compute-engine"
  display_name = "GCE Service Account"
  project = "${google_project.mango_service_project.name}"
}

# terraform service account
#----------------------------------------------------
resource "google_service_account" "tf_mango_service_project" {
  account_id   = "terraform"
  display_name = "Terraform Service Account"
  project = "${google_project.mango_service_project.name}"
}
