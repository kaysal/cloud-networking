# Org admin creates all projects
# to make TF deployment simpler
#-------------------------------
resource "random_id" "suffix" {
  byte_length = 1
}

# GKE Service Project
resource "google_project" "gke_service_project" {
  name = "gke-service-project-${random_id.suffix.hex}"
  project_id = "gke-service-project-${random_id.suffix.hex}"
  folder_id  = "${google_folder.gke_folder.name}"
  billing_account = "${var.billing_account_id}"
}

# Give the terraform service accounts project owner roles
#----------------------------------------------------
resource "google_project_iam_policy" "gke_service_project" {
  project = "${google_project.gke_service_project.name}"
  policy_data = "${data.google_iam_policy.gke_service_project_policy.policy_data}"
}

data "google_iam_policy" "gke_service_project_policy" {
  binding {
    role = "roles/owner"
    members = [
      "serviceAccount:${google_service_account.tf_gke_service_project.email}",
    ]
  }
}
