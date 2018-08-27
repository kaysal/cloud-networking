# enable compute and storage services
#-------------------------------
resource "google_project_services" "gke_service_project" {
  project = "${google_project.gke_service_project.project_id}"
  services = [
    "storage-api.googleapis.com",
    "compute.googleapis.com",
    "container.googleapis.com",
  ]
}
