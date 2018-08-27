# enable compute and storage services
#-------------------------------
resource "google_project_services" "apple_service_project" {
  project = "${google_project.apple_service_project.project_id}"
  services = [
    "compute.googleapis.com",
    "storage-api.googleapis.com",
    "container.googleapis.com",
  ]
}
