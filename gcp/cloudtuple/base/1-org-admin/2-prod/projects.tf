# Org admin creates all projects
# to make TF deployment simpler
#-------------------------------
resource "random_id" "suffix" {
  byte_length = 1
}

# Prod Service Project
resource "google_project" "prod_service_project" {
  name = "prod-service-project-${random_id.suffix.hex}"
  project_id = "prod-service-project-${random_id.suffix.hex}"
  folder_id  = "${google_folder.prod_folder.name}"
  billing_account = "${var.billing_account_id}"
}
