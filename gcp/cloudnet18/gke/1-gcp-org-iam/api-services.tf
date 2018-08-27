# enable compute and storage services
#-------------------------------
resource "google_project_services" "host_project" {
  project = "${google_project.host_project.project_id}"
  services = [
    "compute.googleapis.com",
    "storage-api.googleapis.com",
  ]
}

// k8s cluster launched in service project
resource "google_project_services" "service_project" {
  project = "${google_project.service_project.project_id}"
  services = [
    "compute.googleapis.com",
    "storage-api.googleapis.com",
  ]
}
