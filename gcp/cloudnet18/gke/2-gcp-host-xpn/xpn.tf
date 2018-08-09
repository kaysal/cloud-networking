# Enable shared VPC hosting in the host project
resource "google_compute_shared_vpc_host_project" "host_project" {
  project    = "${data.terraform_remote_state.iam.host_project_id}"
}

# Enable shared VPC service project
resource "google_compute_shared_vpc_service_project" "service_project" {
  host_project    = "${data.terraform_remote_state.iam.host_project_id}"
  service_project = "${data.terraform_remote_state.iam.service_project_id}"

  depends_on = ["google_compute_shared_vpc_host_project.host_project"]
}

# Enable network access to host project for
# terraform service account and user groups
# for each project
#-------------------
# network access at project level
resource "google_project_iam_binding" "service_project_compute_network_user" {
  project    = "${data.terraform_remote_state.iam.host_project_id}"
  role    = "roles/compute.networkUser"
  members = [
    "group:prod-grp@cloudtuple.com",
    "serviceAccount:${data.terraform_remote_state.iam.tf_service_project_service_account_email}",
  ]
}
