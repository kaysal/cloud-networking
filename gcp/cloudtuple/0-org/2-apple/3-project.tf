# Org admin creates all projects
# to make TF deployment simpler
#-------------------------------
resource "random_id" "suffix" {
  byte_length = 1
}

# Prod Service Project
resource "google_project" "apple_service_project" {
  name = "apple-service-project-${random_id.suffix.hex}"
  project_id = "apple-service-project-${random_id.suffix.hex}"
  folder_id  = "${google_folder.apple_folder.name}"
  billing_account = "${var.billing_account_id}"
}

# Give the terraform and vm service account projects owner role
#----------------------------------------------------
resource "google_project_iam_binding" "apple_service_project_owner" {
  project = "${google_project.apple_service_project.name}"
  role = "roles/owner"
  members  = [
    "serviceAccount:${google_service_account.vm_apple_service_project.email}",
    "serviceAccount:${google_service_account.tf_apple_service_project.email}"
    ]
}

# project metadata
#----------------------------------------------------
resource "google_compute_project_metadata" "zonal_dns" {
  project = "${google_project.apple_service_project.name}"
  metadata {
    VmDnsSetting = "ZonalPreferred"
  }
}
