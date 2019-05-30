# Org admin creates all projects
# to make TF deployment simpler
#-------------------------------
resource "random_id" "suffix" {
  byte_length = 1
}

# Host Project
resource "google_project" "host_project" {
  name            = "host-project-${random_id.suffix.hex}"
  project_id      = "host-project-${random_id.suffix.hex}"
  folder_id       = "${google_folder.host_folder.name}"
  billing_account = "${var.billing_account_id}"

  lifecycle {
    prevent_destroy = true
  }

  app_engine {}
}
