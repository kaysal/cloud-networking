# Org admin creates all projects
# to make TF deployment simpler
#-------------------------------
resource "random_id" "suffix" {
  byte_length = 1
}

# Host Project
resource "google_project" "host_project" {
  name = "host-project-${random_id.suffix.hex}"
  project_id = "host-project-${random_id.suffix.hex}"
  folder_id  = "${google_folder.host_folder.name}"
  billing_account = "${var.billing_account_id}"
}

# Give service accounts project owner roles
#----------------------------------------------------
resource "google_project_iam_member" "project_owner_tf_svc_acct" {
  project = "${google_project.host_project.name}"
  role    = "roles/owner"
  member  = "serviceAccount:${google_service_account.tf_host_project.email}"
}

resource "google_project_iam_member" "project_owner_vm_svc_acct" {
  project = "${google_project.host_project.name}"
  role    = "roles/owner"
  member  = "serviceAccount:${google_service_account.vm_host_project.email}"
}
