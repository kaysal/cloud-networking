# Org admin creates all projects
# to make TF deployment simpler
#-------------------------------
resource "random_id" "suffix" {
  byte_length = 1
}

# Prod Service Project
resource "google_project" "orange_service_project" {
  name = "orange-service-project-${random_id.suffix.hex}"
  project_id = "orange-service-project-${random_id.suffix.hex}"
  folder_id  = "${google_folder.orange_folder.name}"
  billing_account = "${var.billing_account_id}"
}

# Give the terraform service account project owner role
#----------------------------------------------------
resource "google_project_iam_policy" "orange_service_project" {
  project = "${google_project.orange_service_project.name}"
  policy_data = "${data.google_iam_policy.orange_service_project_policy.policy_data}"
}

data "google_iam_policy" "orange_service_project_policy" {
  binding {
    role = "roles/owner"
    members = [
      "serviceAccount:${google_service_account.tf_orange_service_project.email}",
    ]
  }

  binding {
    role = "roles/dns.admin"
    members = [
      "group:orange-grp@cloudtuple.com",
    ]
  }
}
