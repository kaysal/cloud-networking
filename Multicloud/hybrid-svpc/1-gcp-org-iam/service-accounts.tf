# Create hosts and service projects
# The projects are created upfront by Org admin
# to make it easier (for Terraform demo) to assign IAM roles
# upfront
#-------------------------------
# Host Project
resource "google_project" "netsec_host_project" {
  name = "${var.name}netsec-host-project"
  project_id = "${var.name}netsec-host-project"
  folder_id  = "${google_folder.netsec_folder.name}"
  billing_account = "${var.billing_account_id}"
}

# Prod Service Project
resource "google_project" "prod_service_project" {
  name = "${var.name}prod-service-project"
  project_id = "${var.name}prod-service-project"
  folder_id  = "${google_folder.prod_folder.name}"
  billing_account = "${var.billing_account_id}"
}

# Test Service Project
resource "google_project" "test_service_project" {
  name = "${var.name}test-service-project"
  project_id = "${var.name}test-service-project"
  folder_id  = "${google_folder.test_folder.name}"
  billing_account = "${var.billing_account_id}"
}

# Create service accounts for host and service projects
# These service accounts will be used by project instances and
# will be given cloud-platform scope at instance creation.
# The service accounts are created upfront by Org admin
# to make it easier (for Teerform demo) to assign IAM roles
# upfront, rather than roles assigned at service project level
#----------------------------------------------------
resource "google_service_account" "instance_netsec_host_project" {
  account_id   = "instance-netsec-host-project"
  display_name = "host project instance service account"
  project = "${google_project.netsec_host_project.name}"
}

resource "google_service_account" "instance_prod_service_project" {
  account_id   = "instance-prod-service-project"
  display_name = "prod service project service account"
  project = "${google_project.prod_service_project.name}"
}

resource "google_service_account" "instance_test_service_project" {
  account_id   = "instance-test-service-project"
  display_name = "test service project service account"
  project = "${google_project.test_service_project.name}"
}

# Create service accounts for host and service projects
# These service accounts have to be given compute.network.user
# roles by Shared VPC admin. The service accounts are the
# credentials for Terraform scripts for service projects
#----------------------------------------------------
resource "google_service_account" "tf_netsec_host_project" {
  account_id   = "tf-netsec-host-project"
  display_name = "netsec-host-project TF service account"
  project = "${google_project.netsec_host_project.name}"
}

resource "google_service_account" "tf_prod_service_project" {
  account_id   = "tf-prod-service-project"
  display_name = "prod-service-project TF service account"
  project = "${google_project.prod_service_project.name}"
}

resource "google_service_account" "tf_test_service_project" {
  account_id   = "tf-test-service-project"
  display_name = "test-service-project TF service account"
  project = "${google_project.test_service_project.name}"
}

# Give the terraform service accounts project owner roles
#----------------------------------------------------
resource "google_project_iam_policy" "netsec_project" {
  project = "${google_project.netsec_host_project.name}"
  policy_data = "${data.google_iam_policy.netsec_project_policy.policy_data}"
}

data "google_iam_policy" "netsec_project_policy" {
  binding {
    role = "roles/owner"
    members = [
      "serviceAccount:${google_service_account.tf_netsec_host_project.email}",
    ]
  }
}

resource "google_project_iam_policy" "prod_project" {
  project = "${google_project.prod_service_project.name}"
  policy_data = "${data.google_iam_policy.prod_project_policy.policy_data}"
}

data "google_iam_policy" "prod_project_policy" {
  binding {
    role = "roles/owner"
    members = [
      "serviceAccount:${google_service_account.tf_prod_service_project.email}",
    ]
  }
}

resource "google_project_iam_policy" "test_project" {
  project = "${google_project.test_service_project.name}"
  policy_data = "${data.google_iam_policy.test_project_policy.policy_data}"
}

data "google_iam_policy" "test_project_policy" {
  binding {
    role = "roles/owner"
    members = [
      "serviceAccount:${google_service_account.tf_test_service_project.email}",
    ]
  }
}
