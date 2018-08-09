
# vm service account
#-----------------------------------------------
resource "google_service_account" "vm_test_service_project" {
  account_id   = "vm-test-service-project"
  display_name = "VM Service Account"
  project = "${google_project.test_service_project.name}"
}

# terraform service account
#----------------------------------------------------
resource "google_service_account" "tf_test_service_project" {
  account_id   = "tf-test-service-project"
  display_name = "Terraform Service Account"
  project = "${google_project.test_service_project.name}"
}

# Give the terraform service account project owner role
#----------------------------------------------------
resource "google_project_iam_policy" "test_project" {
  project = "${google_project.test_service_project.name}"
  policy_data = "${data.google_iam_policy.test_project_policy.policy_data}"
}

data "google_iam_policy" "test_project_policy" {
  binding {
    role = "roles/owner"
    members = [
      "serviceAccount:${google_service_account.tf_test_service_project.email}",
    ]
  }
}
