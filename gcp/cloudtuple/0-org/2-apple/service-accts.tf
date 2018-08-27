
# vm service account
#-----------------------------------------------
resource "google_service_account" "vm_apple_service_project" {
  account_id   = "compute-engine"
  display_name = "GCE Service Account"
  project = "${google_project.apple_service_project.name}"
}

# terraform service account
#----------------------------------------------------
resource "google_service_account" "tf_apple_service_project" {
  account_id   = "terraform"
  display_name = "Terraform Service Account"
  project = "${google_project.apple_service_project.name}"
}
