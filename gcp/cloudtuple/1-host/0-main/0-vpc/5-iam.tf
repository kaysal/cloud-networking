# Enable shared VPC hosting in the host project
resource "google_compute_shared_vpc_host_project" "host_project" {
  project = "${data.terraform_remote_state.host.host_project_id}"
}

# Enable shared VPC service project
resource "google_compute_shared_vpc_service_project" "apple_service_project" {
  host_project    = "${data.terraform_remote_state.host.host_project_id}"
  service_project = "${data.terraform_remote_state.apple.apple_service_project_id}"

  depends_on = ["google_compute_shared_vpc_host_project.host_project"]
}

resource "google_compute_shared_vpc_service_project" "gke_service_project" {
  host_project    = "${data.terraform_remote_state.host.host_project_id}"
  service_project = "${data.terraform_remote_state.gke.gke_service_project_id}"

  depends_on = ["google_compute_shared_vpc_host_project.host_project"]
}

# Host Compute Network User (Project Level)
#===================================
# apple-grp@: compute network user (project level access given to only apple service project)
# apple terraform service account: network access
# apple compute engine default sevice account: network user role for creating GCLB MIG in host network
# cloud function network user role

resource "google_project_iam_binding" "project_network_user" {
  project = "${data.terraform_remote_state.host.host_project_id}"
  role    = "roles/compute.networkUser"

  members = [
    "group:apple-grp@cloudtuple.com",
    "serviceAccount:${data.terraform_remote_state.apple.apple_service_project_number}@cloudservices.gserviceaccount.com",
    "serviceAccount:service-${data.terraform_remote_state.host.host_project_number}@gcf-admin-robot.iam.gserviceaccount.com",
  ]
}

# Host Project Service Agent User
#===================================
resource "google_project_iam_member" "host_service_agent_user_gke_project_robot" {
  project = "${data.terraform_remote_state.host.host_project_id}"
  role    = "roles/container.hostServiceAgentUser"
  member  = "serviceAccount:service-${data.terraform_remote_state.gke.gke_service_project_number}@container-engine-robot.iam.gserviceaccount.com"
}

# Host Project DNS admin (to configure zone records)
#===================================
resource "google_project_iam_binding" "project_dns_admin" {
  project = "${data.terraform_remote_state.host.host_project_id}"
  role    = "roles/dns.admin"

  members = [
    "group:apple-grp@cloudtuple.com",
    "group:orange-grp@cloudtuple.com",
    "group:mango-grp@cloudtuple.com",
    "group:gke-grp@cloudtuple.com",
  ]
}

# Host Compute Network User (Subnet Level)
#===================================
# GKE EU_WEST1
#------------------
# gke-grp@: compute network user at subnet level
# gke terraform Service Account: network access at subnet level
# gke...@cloudservices.gserviceaccount.com service account is granted the Compute Network User role
# @container-engine-robot.iam.gserviceaccount.com service account is granted the Compute Network User role

resource "google_compute_subnetwork_iam_binding" "gke_eu_w1_10_0_4" {
  provider   = "google-beta"
  subnetwork = "${google_compute_subnetwork.gke_eu_w1_10_0_4.name}"
  region     = "europe-west1"
  role       = "roles/compute.networkUser"

  members = [
    "group:gke-grp@cloudtuple.com",
    "serviceAccount:${data.terraform_remote_state.gke.gke_service_project_number}@cloudservices.gserviceaccount.com",
    "serviceAccount:service-${data.terraform_remote_state.gke.gke_service_project_number}@container-engine-robot.iam.gserviceaccount.com",
  ]
}

# GKE EU-WEST2
#------------------
# gke-grp@: compute network user at subnet level
# gke terraform Service Account: network access at subnet level
# gke...@cloudservices.gserviceaccount.com service account is granted the Compute Network User role
# @container-engine-robot.iam.gserviceaccount.com service account is granted the Compute Network User role

resource "google_compute_subnetwork_iam_binding" "gke_eu_w2_10_0_8" {
  provider   = "google-beta"
  subnetwork = "${google_compute_subnetwork.gke_eu_w2_10_0_8.name}"
  region     = "europe-west2"
  role       = "roles/compute.networkUser"

  members = [
    "group:gke-grp@cloudtuple.com",
    "serviceAccount:${data.terraform_remote_state.gke.gke_service_project_number}@cloudservices.gserviceaccount.com",
    "serviceAccount:service-${data.terraform_remote_state.gke.gke_service_project_number}@container-engine-robot.iam.gserviceaccount.com",
  ]
}

# DNS Peering
#===================================
resource "google_project_iam_binding" "dns_peer" {
  provider = "google-beta"
  role     = "roles/dns.peer"

  members = [
    "serviceAccount:${data.terraform_remote_state.orange.vm_orange_project_service_account_email}",
    "serviceAccount:${data.terraform_remote_state.mango.vm_mango_project_service_account_email}",
  ]
}
