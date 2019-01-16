# enable compute and storage services
#-------------------------------
resource "google_project_services" "prod_service_project" {
  project = "${google_project.prod_service_project.project_id}"
  services = [
    "storage-api.googleapis.com",
    "compute.googleapis.com",
  ]
}
