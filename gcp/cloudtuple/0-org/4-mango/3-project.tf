# Org admin creates all projects
# to make TF deployment simpler
#-------------------------------
resource "random_id" "suffix" {
  byte_length = 1
}

# Prod Service Project
resource "google_project" "mango_project" {
  name = "mango-project-${random_id.suffix.hex}"
  project_id = "mango-project-${random_id.suffix.hex}"
  folder_id  = "${google_folder.mango_folder.name}"
  billing_account = "${var.billing_account_id}"
}

# Give the terraform and vm service account projects owner role
#----------------------------------------------------
resource "google_project_iam_member" "mango_project_vm_svc_acct" {
  project = "${google_project.mango_project.name}"
  role = "roles/owner"
  member  = "serviceAccount:${google_service_account.vm_mango_project.email}"
}

resource "google_project_iam_member" "mango_project_tf_svc_acct" {
  project = "${google_project.mango_project.name}"
  role = "roles/owner"
  member  = "serviceAccount:${google_service_account.tf_mango_project.email}"
}
