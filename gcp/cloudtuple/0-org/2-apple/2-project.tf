# Org admin creates all projects
# to make TF deployment simpler
#-------------------------------
resource "random_id" "suffix" {
  byte_length = 1
}

# Prod Service Project
resource "google_project" "apple_service_project" {
  name = "apple-service-project-${random_id.suffix.hex}"
  project_id = "apple-service-project-${random_id.suffix.hex}"
  folder_id  = "${google_folder.apple_folder.name}"
  billing_account = "${var.billing_account_id}"
}
