# Org admin creates all projects
# to make TF deployment simpler
#-------------------------------
resource "random_id" "suffix" {
  byte_length = 1
}

# Prod Service Project
resource "google_project" "orange_project" {
  name = "orange-project-${random_id.suffix.hex}"
  project_id = "orange-project-${random_id.suffix.hex}"
  folder_id  = "${google_folder.orange_folder.name}"
  billing_account = "${var.billing_account_id}"
}

# Give the terraform and vm service account project owner role
#----------------------------------------------------
resource "google_project_iam_member" "orange_project_vm_svc_acct" {
  project = "${google_project.orange_project.name}"
  role = "roles/owner"
  member  = "serviceAccount:${google_service_account.vm_orange_project.email}"
}

resource "google_project_iam_member" "orange_project_tf_svc_acct" {
  project = "${google_project.orange_project.name}"
  role = "roles/owner"
  member  = "serviceAccount:${google_service_account.tf_orange_project.email}"
}

# Give the terraform and vm service account dns admin role
#===================================
resource "google_project_iam_member" "dns_admin_orange_grp" {
  project = "${google_project.orange_project.name}"
  role  = "roles/dns.admin"
  member  = "group:orange-grp@cloudtuple.com"
}

resource "google_project_iam_member" "dns_admin_tf_svc_acct" {
  project = "${google_project.orange_project.name}"
  role  = "roles/dns.admin"
  member  = "serviceAccount:${google_service_account.tf_orange_project.email}"
}
