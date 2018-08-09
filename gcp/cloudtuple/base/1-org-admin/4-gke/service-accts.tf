# vm service accounts for all projects
#-----------------------------------------------
resource "google_service_account" "node_gke_service_project" {
  account_id   = "node-gke-service-project"
  display_name = "K8s Node Service Account"
  project = "${google_project.gke_service_project.name}"
}

# terraform service accounts
#----------------------------------------------------
resource "google_service_account" "tf_gke_service_project" {
  account_id   = "tf-gke-service-project"
  display_name = "Terraform Service Account"
  project = "${google_project.gke_service_project.name}"
}

# Give the terraform service accounts project owner roles
#----------------------------------------------------
resource "google_project_iam_policy" "gke_project" {
  project = "${google_project.gke_service_project.name}"
  policy_data = "${data.google_iam_policy.gke_project_policy.policy_data}"
}

data "google_iam_policy" "gke_project_policy" {
  binding {
    role = "roles/owner"
    members = [
      "serviceAccount:${google_service_account.tf_gke_service_project.email}",
    ]
  }
}
