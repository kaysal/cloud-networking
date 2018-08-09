# Create hosts and service projects
# The projects are created upfront by Org admin
# to make it easier (for terraform demo) to assign IAM roles
# upfront
#-------------------------------
# Host Project
resource "google_project" "host_project" {
  name = "${var.name}host-project"
  project_id = "${var.name}host-project"
  folder_id  = "${google_folder.host_folder.name}"
  billing_account = "${var.billing_account_id}"
}

# Prod Service Project
resource "google_project" "service_project" {
  name = "${var.name}service-project"
  project_id = "${var.name}service-project"
  folder_id  = "${google_folder.service_folder.name}"
  billing_account = "${var.billing_account_id}"
}
