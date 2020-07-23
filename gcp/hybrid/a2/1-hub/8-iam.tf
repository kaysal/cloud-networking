
# hub shared vpc hosting
#-------------------------------------

resource "google_compute_shared_vpc_host_project" "hub_project" {
  project = var.project_id_hub
}

# service projects
#-------------------------------------

resource "google_compute_shared_vpc_service_project" "spoke1" {
  host_project    = var.project_id_hub
  service_project = var.project_id_spoke1

  depends_on = [google_compute_shared_vpc_host_project.hub_project]
}

resource "google_compute_shared_vpc_service_project" "spoke2" {
  host_project    = var.project_id_hub
  service_project = var.project_id_spoke2

  depends_on = [google_compute_shared_vpc_host_project.hub_project]
}

# compute network user
#-------------------------------------

# compute engine default

resource "google_project_iam_member" "spoke1_compute" {
  project = var.project_id_hub
  role    = "roles/compute.networkUser"
  member  = "serviceAccount:${var.project_number_spoke1}@cloudservices.gserviceaccount.com"
}

resource "google_project_iam_member" "spoke2_compute" {
  project = var.project_id_hub
  role    = "roles/compute.networkUser"
  member  = "serviceAccount:${var.project_number_spoke2}@cloudservices.gserviceaccount.com"
}

# cloud function

resource "google_project_iam_member" "spoke1_cloud_function" {
  project = var.project_id_hub
  role    = "roles/compute.networkUser"
  member  = "serviceAccount:service-${var.project_number_spoke1}@gcf-admin-robot.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "spoke2_cloud_function" {
  project = var.project_id_hub
  role    = "roles/compute.networkUser"
  member  = "serviceAccount:service-${var.project_number_spoke2}@gcf-admin-robot.iam.gserviceaccount.com"
}

# gke robot
#-------------------------------------

resource "google_project_iam_member" "spoke1_gke_robot" {
  project = var.project_id_hub
  role    = "roles/container.hostServiceAgentUser"
  member  = "serviceAccount:service-${var.project_number_spoke1}@container-engine-robot.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "spoke2_gke_robot" {
  project = var.project_id_hub
  role    = "roles/container.hostServiceAgentUser"
  member  = "serviceAccount:service-${var.project_number_spoke2}@container-engine-robot.iam.gserviceaccount.com"
}
