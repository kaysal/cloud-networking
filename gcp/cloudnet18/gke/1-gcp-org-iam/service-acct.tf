# Create service accounts for host and service projects
# These service accounts will be used by project instances and
# will be given cloud-platform scope at instance creation.
# The service accounts are created upfront by Org admin
# to make it easier (for Teraform) to assign IAM roles
# upfront
#----------------------------------------------------
resource "google_service_account" "instance_host_project" {
  account_id   = "instance-host-project"
  display_name = "host-project instance service account"
  project = "${google_project.host_project.name}"
}

resource "google_service_account" "instance_service_project" {
  account_id   = "instance-service-project"
  display_name = "service-project instance service account"
  project = "${google_project.service_project.name}"
}

# special service account for k8s cluster nodes
#----------------------------------------------------
resource "google_service_account" "k8s_node_service_project" {
  account_id   = "k8s-node-service-project"
  display_name = "service-project k8s-node service account"
  project = "${google_project.service_project.name}"
}

# Create service accounts for host and service projects.
# These service accounts have to be given compute.network.user
# roles by Shared VPC admin. The service accounts are the
# credentials for terraform scripts for service projects
#----------------------------------------------------
resource "google_service_account" "tf_host_project" {
  account_id   = "tf-host-project"
  display_name = "host-project TF service account"
  project = "${google_project.host_project.name}"
}

resource "google_service_account" "tf_service_project" {
  account_id   = "tf-service-project"
  display_name = "service-project TF service account"
  project = "${google_project.service_project.name}"
}

# Give the appropriate service accounts, project owner roles
#----------------------------------------------------
resource "google_project_iam_policy" "host_project" {
  project = "${google_project.host_project.name}"
  policy_data = "${data.google_iam_policy.host_project_policy.policy_data}"
}

data "google_iam_policy" "host_project_policy" {
  binding {
    role = "roles/owner"
    members = [
      "serviceAccount:${google_service_account.tf_host_project.email}",
      "serviceAccount:${google_service_account.instance_host_project.email}",
    ]
  }
}

resource "google_project_iam_policy" "service_project" {
  project = "${google_project.service_project.name}"
  policy_data = "${data.google_iam_policy.service_project_policy.policy_data}"
}

data "google_iam_policy" "service_project_policy" {
  binding {
    role = "roles/owner"
    members = [
      "serviceAccount:${google_service_account.tf_service_project.email}",
      "serviceAccount:${google_service_account.instance_service_project.email}",
    ]
  }

  binding {
    role = "roles/compute.instanceAdmin"
    members = [
      "serviceAccount:${google_service_account.k8s_node_service_project.email}",
    ]
  }

  binding {
    role = "roles/logging.logWriter"
    members = [
      "serviceAccount:${google_service_account.k8s_node_service_project.email}",
    ]
  }

  binding {
    role = "roles/monitoring.admin"
    members = [
      "serviceAccount:${google_service_account.k8s_node_service_project.email}",
    ]
  }

  binding {
    role = "roles/storage.objectViewer"
    members = [
      "serviceAccount:${google_service_account.k8s_node_service_project.email}",
]
  }
}
