# terraform service accounts
#----------------------------------------------------
resource "google_service_account" "tf_host_project" {
  account_id   = "terraform"
  display_name = "Terraform Service Account"
  project = "${google_project.host_project.name}"
}
