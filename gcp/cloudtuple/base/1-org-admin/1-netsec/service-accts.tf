
# vm service accounts for all projects
#-----------------------------------------------
resource "google_service_account" "vm_netsec_host_project" {
  account_id   = "vm-netsec-host-project"
  display_name = "VM Service Account"
  project = "${google_project.netsec_host_project.name}"
}

# terraform service accounts
#----------------------------------------------------
resource "google_service_account" "tf_netsec_host_project" {
  account_id   = "tf-netsec-host-project"
  display_name = "Terraform Service Account"
  project = "${google_project.netsec_host_project.name}"
}

# Give the terraform service accounts project owner roles
#----------------------------------------------------
resource "google_project_iam_policy" "netsec_project" {
  project = "${google_project.netsec_host_project.name}"
  policy_data = "${data.google_iam_policy.netsec_project_policy.policy_data}"
}

data "google_iam_policy" "netsec_project_policy" {
  binding {
    role = "roles/owner"
    members = [
      "serviceAccount:${google_service_account.tf_netsec_host_project.email}",
    ]
  }
}
