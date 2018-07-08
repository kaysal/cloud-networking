# enable compute and storage services
#-------------------------------
resource "google_project_services" "netsec_host_project" {
  project = "${google_project.netsec_host_project.project_id}"
  services = [
    "compute.googleapis.com",
    "storage-api.googleapis.com",
  ]
}

resource "google_project_services" "prod_service_project" {
  project = "${google_project.prod_service_project.project_id}"
  services = [
    "compute.googleapis.com",
    "storage-api.googleapis.com",
  ]
}

resource "google_project_services" "test_service_project" {
  project = "${google_project.test_service_project.project_id}"
  services = [
    "storage-api.googleapis.com",
    "compute.googleapis.com",
  ]
}
