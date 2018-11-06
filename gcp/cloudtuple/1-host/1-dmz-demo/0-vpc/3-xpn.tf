# Enable shared VPC service project
resource "google_compute_shared_vpc_service_project" "prod_service_project" {
  host_project    = "${data.terraform_remote_state.host.host_project_id}"
  service_project = "${data.terraform_remote_state.prod.prod_service_project_id}"
}

resource "google_compute_shared_vpc_service_project" "dev_service_project" {
  host_project    = "${data.terraform_remote_state.host.host_project_id}"
  service_project = "${data.terraform_remote_state.dev.dev_service_project_id}"
}

# host project: network policies
#-------------------------------
resource "google_compute_subnetwork_iam_policy" "prod_subnet" {
  subnetwork = "${google_compute_subnetwork.prod_subnet.name}"
  region = "europe-west1"
  policy_data = "${data.google_iam_policy.prod_subnet_policy.policy_data}"
}

data "google_iam_policy" "prod_subnet_policy" {

  # prod-grp@: compute network user at subnet level
  # prod terraform Service Account: network access at subnet level
  # prod...@cloudservices.gserviceaccount.com service account needs access to create MIG instance in subnet
  binding {
    role  = "roles/compute.networkUser"
    members = [
      "group:prod-grp@cloudtuple.com",
      "serviceAccount:${data.terraform_remote_state.prod.tf_prod_service_project_service_account_email}",
      "serviceAccount:${data.terraform_remote_state.prod.prod_service_project_number}@cloudservices.gserviceaccount.com"
    ]
  }
}

resource "google_compute_subnetwork_iam_policy" "dev_subnet" {
  subnetwork = "${google_compute_subnetwork.dev_subnet.name}"
  region = "europe-west1"
  policy_data = "${data.google_iam_policy.dev_subnet_policy.policy_data}"
}

data "google_iam_policy" "dev_subnet_policy" {

  # dev-grp@: compute network user at subnet level
  # dev terraform Service Account: network access at subnet level
  # dev...@cloudservices.gserviceaccount.com service account needs access to create MIG instance in subnet
  binding {
    role  = "roles/compute.networkUser"
    members = [
      "group:dev-grp@cloudtuple.com",
      "serviceAccount:${data.terraform_remote_state.dev.tf_dev_service_project_service_account_email}",
      "serviceAccount:${data.terraform_remote_state.dev.dev_service_project_number}@cloudservices.gserviceaccount.com"
    ]
  }
}
