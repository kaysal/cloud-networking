# enable compute and storage services
#-------------------------------
resource "google_project_services" "host_project" {
  project = "${google_project.host_project.project_id}"
  services = [
    "compute.googleapis.com",
    "storage-api.googleapis.com",
    "container.googleapis.com",
  ]
}
