# enable compute and storage services
#-------------------------------
resource "google_project_services" "prod_service_project" {
  project = "${google_project.prod_service_project.project_id}"
  services = [
    "compute.googleapis.com",
    "storage-api.googleapis.com",
    "container.googleapis.com",
  ]
}
