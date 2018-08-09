
# vm service account
#-----------------------------------------------
resource "google_service_account" "vm_prod_service_project" {
  account_id   = "vm-prod-service-project"
  display_name = "VM Service Account"
  project = "${google_project.prod_service_project.name}"
}

# terraform service account
#----------------------------------------------------
resource "google_service_account" "tf_prod_service_project" {
  account_id   = "tf-prod-service-project"
  display_name = "Terraform Service Account"
  project = "${google_project.prod_service_project.name}"
}

# Give the terraform service account project owner role
#----------------------------------------------------
resource "google_project_iam_policy" "prod_project" {
  project = "${google_project.prod_service_project.name}"
  policy_data = "${data.google_iam_policy.prod_project_policy.policy_data}"
}

data "google_iam_policy" "prod_project_policy" {
  binding {
    role = "roles/owner"
    members = [
      "serviceAccount:${google_service_account.tf_prod_service_project.email}",
    ]
  }
}
