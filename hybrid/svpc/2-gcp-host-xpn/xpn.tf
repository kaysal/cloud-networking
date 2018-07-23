# Enable shared VPC hosting in the host project
resource "google_compute_shared_vpc_host_project" "netsec_host_project" {
  project    = "${data.terraform_remote_state.iam.netsec_host_project_id}"
}

# Enable shared VPC service project
resource "google_compute_shared_vpc_service_project" "prod_service_project" {
  host_project    = "${data.terraform_remote_state.iam.netsec_host_project_id}"
  service_project = "${data.terraform_remote_state.iam.prod_service_project_id}"

  depends_on = ["google_compute_shared_vpc_host_project.netsec_host_project"]
}

resource "google_compute_shared_vpc_service_project" "test_service_project" {
  host_project    = "${data.terraform_remote_state.iam.netsec_host_project_id}"
  service_project = "${data.terraform_remote_state.iam.test_service_project_id}"

  depends_on = ["google_compute_shared_vpc_host_project.netsec_host_project"]
}

# Enable network access to host project for
# terraform service account and user groups
# for each project
#-------------------
# network access at project level
resource "google_project_iam_binding" "prod_project_compute_network_user" {
  project    = "${data.terraform_remote_state.iam.netsec_host_project_id}"
  role    = "roles/compute.networkUser"
  members = [
    "group:prod-grp@cloudtuple.com",
    "serviceAccount:${data.terraform_remote_state.iam.tf_prod_service_project_service_account_email}",
  ]
}

# network access at subnet level
resource "google_compute_subnetwork_iam_binding" "test_project_compute_network_user_us_e1_subnet_10_50_10" {
  subnetwork = "${google_compute_subnetwork.us_e1_subnet_10_50_10.name}"
  region        = "us-east1"
  role       = "roles/compute.networkUser"
  members = [
    "group:test-grp@cloudtuple.com",
    "serviceAccount:${data.terraform_remote_state.iam.tf_test_service_project_service_account_email}",
  ]
}
