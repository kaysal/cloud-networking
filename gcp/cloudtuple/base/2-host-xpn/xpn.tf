# Enable shared VPC hosting in the host project
resource "google_compute_shared_vpc_host_project" "netsec_host_project" {
  project    = "${data.terraform_remote_state.netsec.netsec_host_project_id}"
}

# Enable shared VPC service project
resource "google_compute_shared_vpc_service_project" "prod_service_project" {
  host_project    = "${data.terraform_remote_state.netsec.netsec_host_project_id}"
  service_project = "${data.terraform_remote_state.prod.prod_service_project_id}"

  depends_on = ["google_compute_shared_vpc_host_project.netsec_host_project"]
}

resource "google_compute_shared_vpc_service_project" "test_service_project" {
  host_project    = "${data.terraform_remote_state.netsec.netsec_host_project_id}"
  service_project = "${data.terraform_remote_state.test.test_service_project_id}"

  depends_on = ["google_compute_shared_vpc_host_project.netsec_host_project"]
}

resource "google_compute_shared_vpc_service_project" "gke_service_project" {
  host_project    = "${data.terraform_remote_state.netsec.netsec_host_project_id}"
  service_project = "${data.terraform_remote_state.gke.gke_service_project_id}"

  depends_on = ["google_compute_shared_vpc_host_project.netsec_host_project"]
}

# Enable network access to host project for
# terraform service account and user groups
# for each project
#-------------------
resource "google_project_iam_policy" "netsec_host_project" {
  project    = "${data.terraform_remote_state.netsec.netsec_host_project_id}"
  policy_data = "${data.google_iam_policy.netsec_host_project_policy.policy_data}"
}

data "google_iam_policy" "netsec_host_project_policy" {

  # prod-grp@: compute network user at project level (just for illustration)
  # prod terraform Service Account: network access at project level
  binding {
    role  = "roles/compute.networkUser"
    members = [
      "group:prod-grp@cloudtuple.com",
      "serviceAccount:${data.terraform_remote_state.prod.tf_prod_service_project_service_account_email}",
    ]
  }

  # k8s Engine Service Account: Host Service Agent User role at project level
  binding {
    role  = "roles/container.hostServiceAgentUser"
    members = [
      "serviceAccount:service-${data.terraform_remote_state.gke.gke_service_project_number}@container-engine-robot.iam.gserviceaccount.com",
    ]
  }
}

resource "google_compute_subnetwork_iam_policy" "us_e1_subnet_10_120_10" {
  subnetwork = "${google_compute_subnetwork.us_e1_subnet_10_120_10.name}"
  region        = "us-east1"
  policy_data = "${data.google_iam_policy.us_e1_subnet_10_120_10_policy.policy_data}"
}

data "google_iam_policy" "us_e1_subnet_10_120_10_policy" {

  # test-grp@: compute network usrer at subnet level
  # test terraform Service Account: network access at subnet level
  binding {
    role  = "roles/compute.networkUser"
    members = [
      "group:test-grp@cloudtuple.com",
      "serviceAccount:${data.terraform_remote_state.test.tf_test_service_project_service_account_email}",
    ]
  }
}

resource "google_compute_subnetwork_iam_policy" "k8s_subnet_10_0_8" {
  subnetwork = "${google_compute_subnetwork.k8s_subnet_10_0_8.name}"
  region = "europe-west1"
  policy_data = "${data.google_iam_policy.k8s_subnet_10_0_8_policy.policy_data}"
}

data "google_iam_policy" "k8s_subnet_10_0_8_policy" {

  # gke-grp@: compute network usrer at subnet level
  # gke terraform Service Account: network access at subnet level
  # @cloudservices.gserviceaccount.com service account is granted the Compute Network User role
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
