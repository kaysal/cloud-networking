# Enable shared VPC hosting in the host project
resource "google_compute_shared_vpc_host_project" "host_project" {
  project = data.terraform_remote_state.host.outputs.host_project_id
}

# Enable shared VPC service project
resource "google_compute_shared_vpc_service_project" "apple_service_project" {
  host_project    = data.terraform_remote_state.host.outputs.host_project_id
  service_project = data.terraform_remote_state.apple.outputs.apple_service_project_id

  depends_on = [google_compute_shared_vpc_host_project.host_project]
}

resource "google_compute_shared_vpc_service_project" "gke_service_project" {
  host_project    = data.terraform_remote_state.host.outputs.host_project_id
  service_project = data.terraform_remote_state.gke.outputs.gke_service_project_id

  depends_on = [google_compute_shared_vpc_host_project.host_project]
}

# Host Compute Network User (Project Level)
#-------------------------------------------------

# apple-grp@

resource "google_project_iam_member" "apple_grp_network_user" {
  project = data.terraform_remote_state.host.outputs.host_project_id
  role    = "roles/compute.networkUser"
  member  = "group:apple-grp@cloudtuple.com"
}

# apple compute engine default sevice account (for creating GCLB MIG in host network)

resource "google_project_iam_member" "compute_default_network_user" {
  project = data.terraform_remote_state.host.outputs.host_project_id
  role    = "roles/compute.networkUser"
  member  = "serviceAccount:${data.terraform_remote_state.apple.outputs.apple_service_project_number}@cloudservices.gserviceaccount.com"
}

# cloud function network user role

resource "google_project_iam_member" "cloud_function_network_user" {
  project = data.terraform_remote_state.host.outputs.host_project_id
  role    = "roles/compute.networkUser"
  member  = "serviceAccount:service-${data.terraform_remote_state.host.outputs.host_project_number}@gcf-admin-robot.iam.gserviceaccount.com"
}

# Host Project Service Agent User
#-------------------------------------------------

# gke service project robot

resource "google_project_iam_member" "host_service_agent_user_gke_project_robot" {
  project = data.terraform_remote_state.host.outputs.host_project_id
  role    = "roles/container.hostServiceAgentUser"
  member  = "serviceAccount:service-${data.terraform_remote_state.gke.outputs.gke_service_project_number}@container-engine-robot.iam.gserviceaccount.com"
}

# dns admin (on host project)
#-------------------------------------------------

# apple

resource "google_project_iam_member" "apple_grp_dns_admin" {
  project = data.terraform_remote_state.host.outputs.host_project_id
  role    = "roles/dns.admin"
  member  = "group:apple-grp@cloudtuple.com"
}

# orange

resource "google_project_iam_member" "orange_grp_dns_admin" {
  project = data.terraform_remote_state.host.outputs.host_project_id
  role    = "roles/dns.admin"
  member  = "group:orange-grp@cloudtuple.com"
}

# mango

resource "google_project_iam_member" "mango_grp_dns_admin" {
  project = data.terraform_remote_state.host.outputs.host_project_id
  role    = "roles/dns.admin"
  member  = "group:mango-grp@cloudtuple.com"
}

# gke

resource "google_project_iam_member" "gke_grp_dns_admin" {
  project = data.terraform_remote_state.host.outputs.host_project_id
  role    = "roles/dns.admin"
  member  = "group:gke-grp@cloudtuple.com"
}


# Host Compute Network User - gke_eu_w1_10_0_4 subnet
#-------------------------------------------------

# gke-grp@

resource "google_compute_subnetwork_iam_member" "gke_grp_eu_w1_10_0_4" {
  provider   = google-beta
  subnetwork = google_compute_subnetwork.gke_eu_w1_10_0_4.name
  region     = "europe-west1"
  role       = "roles/compute.networkUser"
  member     = "group:gke-grp@cloudtuple.com"
}

# gke...@cloudservices.gserviceaccount.com service account

resource "google_compute_subnetwork_iam_member" "compute_default_eu_w1_10_0_4" {
  provider   = google-beta
  subnetwork = google_compute_subnetwork.gke_eu_w1_10_0_4.name
  region     = "europe-west1"
  role       = "roles/compute.networkUser"
  member     = "serviceAccount:${data.terraform_remote_state.gke.outputs.gke_service_project_number}@cloudservices.gserviceaccount.com"
}

# @container-engine-robot.iam.gserviceaccount.com service account

resource "google_compute_subnetwork_iam_member" "gke_robot_eu_w1_10_0_4" {
  provider   = google-beta
  subnetwork = google_compute_subnetwork.gke_eu_w1_10_0_4.name
  region     = "europe-west1"
  role       = "roles/compute.networkUser"
  member     = "serviceAccount:service-${data.terraform_remote_state.gke.outputs.gke_service_project_number}@container-engine-robot.iam.gserviceaccount.com"
}

# Host Compute Network User - gke_eu_w1_10_0_4 subnet
#-------------------------------------------------

# gke-grp@: compute network user at subnet level

resource "google_compute_subnetwork_iam_member" "gke_grp_eu_w2_10_0_8" {
  provider   = google-beta
  subnetwork = google_compute_subnetwork.gke_eu_w2_10_0_8.name
  region     = "europe-west2"
  role       = "roles/compute.networkUser"
  member     = "group:gke-grp@cloudtuple.com"
}

# gke...@cloudservices.gserviceaccount.com service account

resource "google_compute_subnetwork_iam_member" "compute_default_eu_w2_10_0_8" {
  provider   = google-beta
  subnetwork = google_compute_subnetwork.gke_eu_w2_10_0_8.name
  region     = "europe-west2"
  role       = "roles/compute.networkUser"
  member     = "serviceAccount:${data.terraform_remote_state.gke.outputs.gke_service_project_number}@cloudservices.gserviceaccount.com"
}

# @container-engine-robot.iam.gserviceaccount.com service account is granted the Compute Network User role

resource "google_compute_subnetwork_iam_member" "gke_robot_eu_w2_10_0_4" {
  provider   = google-beta
  subnetwork = google_compute_subnetwork.gke_eu_w2_10_0_8.name
  region     = "europe-west2"
  role       = "roles/compute.networkUser"
  member     = "serviceAccount:service-${data.terraform_remote_state.gke.outputs.gke_service_project_number}@container-engine-robot.iam.gserviceaccount.com"
}

# DNS Peering
#-------------------------------------------------

# orange project

resource "google_project_iam_member" "orange_dns_peer" {
  provider = google-beta
  role     = "roles/dns.peer"
  member   = "serviceAccount:${data.terraform_remote_state.orange.outputs.vm_orange_project_service_account_email}"
}

# mango project

resource "google_project_iam_member" "mango_dns_peer" {
  provider = google-beta
  role     = "roles/dns.peer"
  member   = "serviceAccount:${data.terraform_remote_state.mango.outputs.vm_mango_project_service_account_email}"
}

# project viewer role
#-------------------------------------------------

# cloud function

resource "google_project_iam_member" "cloud_function_project_viewer" {
  project = data.terraform_remote_state.host.outputs.host_project_id
  role    = "roles/viewer"
  member  = "serviceAccount:service-${data.terraform_remote_state.host.outputs.host_project_number}@gcf-admin-robot.iam.gserviceaccount.com"
}
