# Org admin creates all projects
# to make TF deployment simpler
#-------------------------------
resource "random_id" "suffix" {
  byte_length = 1
}

# Host Project
resource "google_project" "netsec_host_project" {
  name = "netsec-host-project-${random_id.suffix.hex}"
  project_id = "netsec-host-project-${random_id.suffix.hex}"
  folder_id  = "${google_folder.netsec_folder.name}"
  billing_account = "${var.billing_account_id}"
}
