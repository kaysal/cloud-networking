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

# host PROJECT policies
#======================
resource "google_project_iam_policy" "host_project" {
  project    = "${data.terraform_remote_state.host.host_project_id}"
  policy_data = "${data.google_iam_policy.host_project_policy.policy_data}"
}

data "google_iam_policy" "host_project_policy" {

  # apple-grp@: compute network user (project level access given to only apple service project)
  # apple terraform service account: network access
  # apple compute engine default sevice account: network user role for creating GCLB MIG in host network
  binding {
    role  = "roles/compute.networkUser"
    members = [
      "group:apple-grp@cloudtuple.com",
      "serviceAccount:${data.terraform_remote_state.apple.tf_apple_service_project_service_account_email}",
      "serviceAccount:${data.terraform_remote_state.apple.apple_service_project_number}@cloudservices.gserviceaccount.com"
    ]
  }

  # gke engine service account: host service agent user
  binding {
    role  = "roles/container.hostServiceAgentUser"
    members = [
      "serviceAccount:service-${data.terraform_remote_state.gke.gke_service_project_number}@container-engine-robot.iam.gserviceaccount.com",
    ]
  }

  # apple engine service account: DNS admin (to configure zone records)
  binding {
    role  = "roles/dns.admin"
    members = [
      "group:apple-grp@cloudtuple.com",
      "serviceAccount:${data.terraform_remote_state.apple.tf_apple_service_project_service_account_email}"
    ]
  }
}

# host project NETWORK policies
#======================
resource "google_compute_subnetwork_iam_policy" "gke_eu_w1_10_0_4" {
  subnetwork = "${google_compute_subnetwork.gke_eu_w1_10_0_4.name}"
  region = "europe-west1"
  policy_data = "${data.google_iam_policy.gke_eu_w1_10_0_4_policy.policy_data}"
}

data "google_iam_policy" "gke_eu_w1_10_0_4_policy" {

  # gke-grp@: compute network user at subnet level
  # gke terraform Service Account: network access at subnet level
  # gke...@cloudservices.gserviceaccount.com service account is granted the Compute Network User role
  # @container-engine-robot.iam.gserviceaccount.com service account is granted the Compute Network User role
  binding {
    role  = "roles/compute.networkUser"
    members = [
      "group:gke-grp@cloudtuple.com",
      "serviceAccount:${data.terraform_remote_state.gke.tf_gke_service_project_service_account_email}",
      "serviceAccount:${data.terraform_remote_state.gke.gke_service_project_number}@cloudservices.gserviceaccount.com",
      "serviceAccount:service-${data.terraform_remote_state.gke.gke_service_project_number}@container-engine-robot.iam.gserviceaccount.com",
    ]
  }
}

resource "google_compute_subnetwork_iam_policy" "gke_eu_w2_10_0_8" {
  subnetwork = "${google_compute_subnetwork.gke_eu_w2_10_0_8.name}"
  region = "europe-west2"
  policy_data = "${data.google_iam_policy.gke_eu_w2_10_0_8_policy.policy_data}"
}

data "google_iam_policy" "gke_eu_w2_10_0_8_policy" {

  # gke-grp@: compute network user at subnet level
  # gke terraform Service Account: network access at subnet level
  # gke...@cloudservices.gserviceaccount.com service account is granted the Compute Network User role
  # @container-engine-robot.iam.gserviceaccount.com service account is granted the Compute Network User role
  binding {
    role  = "roles/compute.networkUser"
    members = [
      "group:gke-grp@cloudtuple.com",
      "serviceAccount:${data.terraform_remote_state.gke.tf_gke_service_project_service_account_email}",
      "serviceAccount:${data.terraform_remote_state.gke.gke_service_project_number}@cloudservices.gserviceaccount.com",
      "serviceAccount:service-${data.terraform_remote_state.gke.gke_service_project_number}@container-engine-robot.iam.gserviceaccount.com",
    ]
  }
}
