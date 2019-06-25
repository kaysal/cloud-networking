# Org admin creates all projects
# to make TF deployment simpler
#-------------------------------
resource "random_id" "suffix" {
  byte_length = 1
}

# Prod Service Project
resource "google_project" "orange_project" {
  name            = "orange-project-${random_id.suffix.hex}"
  project_id      = "orange-project-${random_id.suffix.hex}"
  folder_id       = google_folder.orange_folder.name
  billing_account = var.billing_account_id

  lifecycle {
    prevent_destroy = true
  }
}

# Give the terraform and vm service account dns admin role
#===================================
resource "google_project_iam_binding" "orange_project_dns_admin" {
  project = google_project.orange_project.id
  role    = "roles/dns.admin"

  members = [
    "group:orange-grp@cloudtuple.com",
  ]
}

