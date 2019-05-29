# Org admin creates all projects
# to make TF deployment simpler
#-------------------------------
resource "random_id" "suffix" {
  byte_length = 1
}

# Forseti Service Project
resource "google_project" "forseti_project" {
  name = "forseti-project-${random_id.suffix.hex}"
  project_id = "forseti-project-${random_id.suffix.hex}"
  folder_id  = "${google_folder.netsec_folder.name}"
  billing_account = "${var.billing_account_id}"

  lifecycle {
    prevent_destroy = true
  }
}
