# enable compute and storage services
#-------------------------------
resource "google_project_services" "dev_service_project" {
  project = "${google_project.dev_service_project.project_id}"
  services = [
    "storage-api.googleapis.com",
    "compute.googleapis.com",
  ]
}
