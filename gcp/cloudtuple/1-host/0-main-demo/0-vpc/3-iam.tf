# Enable shared VPC hosting in the host project
resource "google_compute_shared_vpc_host_project" "host_project" {
  project    = "${data.terraform_remote_state.host.host_project_id}"
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


# Host Project Compute Network User (Project Level)
#===================================
# apple-grp@: compute network user (project level access given to only apple service project)
resource "google_project_iam_member" "network_user_apple_grp" {
  project    = "${data.terraform_remote_state.host.host_project_id}"
  role  = "roles/compute.networkUser"
  member  = "group:apple-grp@cloudtuple.com"
}

# apple terraform service account: network access
resource "google_project_iam_member" "network_user_apple_tf_svc_acct" {
  project    = "${data.terraform_remote_state.host.host_project_id}"
  role  = "roles/compute.networkUser"
  member  = "serviceAccount:${data.terraform_remote_state.apple.tf_apple_service_project_service_account_email}"
}

# apple compute engine default sevice account: network user role for creating GCLB MIG in host network
resource "google_project_iam_member" "network_user_apple_gce_default_svc_acct" {
  project    = "${data.terraform_remote_state.host.host_project_id}"
  role  = "roles/compute.networkUser"
  member  = "serviceAccount:${data.terraform_remote_state.apple.apple_service_project_number}@cloudservices.gserviceaccount.com"
}

# Host Project Service Agent User
#===================================
resource "google_project_iam_member" "host_service_agent_user_gke_project_robot" {
  project    = "${data.terraform_remote_state.host.host_project_id}"
  role  = "roles/container.hostServiceAgentUser"
  member  = "serviceAccount:service-${data.terraform_remote_state.gke.gke_service_project_number}@container-engine-robot.iam.gserviceaccount.com"
}


# Host Project DNS admin (to configure zone records)
#===================================
resource "google_project_iam_member" "dns_admin_apple_apple_grp" {
  project    = "${data.terraform_remote_state.host.host_project_id}"
  role  = "roles/dns.admin"
  member  = "group:apple-grp@cloudtuple.com"
}

resource "google_project_iam_member" "dns_admin_apple_tf_svc_acct" {
  project    = "${data.terraform_remote_state.host.host_project_id}"
  role  = "roles/dns.admin"
  member  = "serviceAccount:${data.terraform_remote_state.apple.tf_apple_service_project_service_account_email}"
}


# Host Project subnetwork policies (Subnet Level)
#===================================
# GKE EU_WEST1
#------------------
# gke-grp@: compute network user at subnet level
resource "google_compute_subnetwork_iam_member" "network_user_gke_eu_w1_10_0_4_gke_grp" {
  subnetwork = "${google_compute_subnetwork.gke_eu_w1_10_0_4.name}"
  region = "europe-west1"
  role  = "roles/compute.networkUser"
  member     = "group:gke-grp@cloudtuple.com"
}

# gke terraform Service Account: network access at subnet level
resource "google_compute_subnetwork_iam_member" "network_user_gke_eu_w1_10_0_4_gke_tf_svc_acct" {
  subnetwork = "${google_compute_subnetwork.gke_eu_w1_10_0_4.name}"
  region = "europe-west1"
  role  = "roles/compute.networkUser"
  member     = "serviceAccount:${data.terraform_remote_state.gke.tf_gke_service_project_service_account_email}"
}

# gke...@cloudservices.gserviceaccount.com service account is granted the Compute Network User role
resource "google_compute_subnetwork_iam_member" "network_user_gke_eu_w1_10_0_4_gke_cloudservices" {
  subnetwork = "${google_compute_subnetwork.gke_eu_w1_10_0_4.name}"
  region = "europe-west1"
  role  = "roles/compute.networkUser"
  member     = "serviceAccount:${data.terraform_remote_state.gke.gke_service_project_number}@cloudservices.gserviceaccount.com"
}

# @container-engine-robot.iam.gserviceaccount.com service account is granted the Compute Network User role
resource "google_compute_subnetwork_iam_member" "network_user_gke_eu_w1_10_0_4_gke_project_robot" {
  subnetwork = "${google_compute_subnetwork.gke_eu_w1_10_0_4.name}"
  region = "europe-west1"
  role  = "roles/compute.networkUser"
  member     = "serviceAccount:service-${data.terraform_remote_state.gke.gke_service_project_number}@container-engine-robot.iam.gserviceaccount.com"
}

# GKE EU-WEST2
#------------------
# gke-grp@: compute network user at subnet level
resource "google_compute_subnetwork_iam_member" "network_user_gke_eu_w2_10_0_8_gke_grp" {
  subnetwork = "${google_compute_subnetwork.gke_eu_w2_10_0_8.name}"
  region = "europe-west2"
  role  = "roles/compute.networkUser"
  member     = "group:gke-grp@cloudtuple.com"
}

# gke terraform Service Account: network access at subnet level
resource "google_compute_subnetwork_iam_member" "network_user_gke_eu_w2_10_0_8_gke_tf_svc_acct" {
  subnetwork = "${google_compute_subnetwork.gke_eu_w2_10_0_8.name}"
  region = "europe-west2"
  role  = "roles/compute.networkUser"
  member     = "serviceAccount:${data.terraform_remote_state.gke.tf_gke_service_project_service_account_email}"
}

# gke...@cloudservices.gserviceaccount.com service account is granted the Compute Network User role
resource "google_compute_subnetwork_iam_member" "network_user_gke_eu_w2_10_0_8_gke_cloudservices" {
  subnetwork = "${google_compute_subnetwork.gke_eu_w2_10_0_8.name}"
  region = "europe-west2"
  role  = "roles/compute.networkUser"
  member     = "serviceAccount:${data.terraform_remote_state.gke.gke_service_project_number}@cloudservices.gserviceaccount.com"
}

# @container-engine-robot.iam.gserviceaccount.com service account is granted the Compute Network User role
resource "google_compute_subnetwork_iam_member" "network_user_gke_eu_w2_10_0_8_gke_project_robot" {
  subnetwork = "${google_compute_subnetwork.gke_eu_w2_10_0_8.name}"
  region = "europe-west2"
  role  = "roles/compute.networkUser"
  member     = "serviceAccount:service-${data.terraform_remote_state.gke.gke_service_project_number}@container-engine-robot.iam.gserviceaccount.com"
}
