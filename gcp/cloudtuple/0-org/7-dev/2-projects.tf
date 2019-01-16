# Org admin creates all projects
# to make TF deployment simpler
#-------------------------------
resource "random_id" "suffix" {
  byte_length = 1
}

# Test Service Project
resource "google_project" "dev_service_project" {
  name = "dev-service-project-${random_id.suffix.hex}"
  project_id = "dev-service-project-${random_id.suffix.hex}"
  folder_id  = "${google_folder.dev_folder.name}"
  billing_account = "${var.billing_account_id}"
}

# Give the terraform service account project owner role
#----------------------------------------------------
resource "google_project_iam_policy" "dev_service_project" {
  project = "${google_project.dev_service_project.name}"
  policy_data = "${data.google_iam_policy.dev_service_project_policy.policy_data}"
}

data "google_iam_policy" "dev_service_project_policy" {
  binding {
    role = "roles/owner"
    members = [
      "serviceAccount:${google_service_account.tf_dev_service_project.email}",
    ]
  }
}
