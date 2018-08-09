# Org admin creates all projects
# to make TF deployment simpler
#-------------------------------
resource "random_id" "suffix" {
  byte_length = 1
}

# Test Service Project
resource "google_project" "test_service_project" {
  name = "test-service-project-${random_id.suffix.hex}"
  project_id = "test-service-project-${random_id.suffix.hex}"
  folder_id  = "${google_folder.test_folder.name}"
  billing_account = "${var.billing_account_id}"
}
