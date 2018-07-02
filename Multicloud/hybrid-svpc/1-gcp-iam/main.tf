# Top-level folders under an organization
#-------------------------------
resource "google_folder" "netsec_folder" {
  display_name = "${var.name}netsec-folder"
  parent     = "organizations/${var.org_id}"
}

resource "google_folder" "prod_folder" {
  display_name = "${var.name}prod-folder"
  parent     = "organizations/${var.org_id}"
}

resource "google_folder" "test_folder" {
  display_name = "${var.name}test-folder"
  parent     = "organizations/${var.org_id}"
}

# IAM policy binding for organization
#-------------------------------
resource "google_organization_iam_binding" "shared_vpc_admin" {
  org_id = "${var.org_id}"
  role    = "roles/compute.xpnAdmin"
  members = [
    "group:netsec-grp@cloudtuple.com",
  ]
}

# IAM policy binding for folders
#-------------------------------
# project owner role to allow authorized group
# to access all project resources
resource "google_folder_iam_binding" "netsec_project_owner" {
  folder  = "${google_folder.netsec_folder.name}"
  role    = "roles/owner"
  members = [
    "group:netsec-grp@cloudtuple.com",
  ]
}

resource "google_folder_iam_binding" "prod_project_owner" {
  folder  = "${google_folder.prod_folder.name}"
  role    = "roles/owner"
  members = [
    "group:prod-grp@cloudtuple.com",
  ]
}

resource "google_folder_iam_binding" "test_project_owner" {
  folder  = "${google_folder.test_folder.name}"
  role    = "roles/owner"
  members = [
    "group:test-grp@cloudtuple.com",
  ]
}

# folder editor role to allow authorized group
# edit rights to folder
resource "google_folder_iam_binding" "netsec_folder_editor" {
  folder  = "${google_folder.netsec_folder.name}"
  role    = "roles/resourcemanager.folderEditor"
  members = [
    "group:netsec-grp@cloudtuple.com",
  ]
}

resource "google_folder_iam_binding" "prod_folder_editor" {
  folder  = "${google_folder.prod_folder.name}"
  role    = "roles/resourcemanager.folderEditor"
  members = [
    "group:prod-grp@cloudtuple.com",
  ]
}

resource "google_folder_iam_binding" "test_folder_editor" {
  folder  = "${google_folder.test_folder.name}"
  role    = "roles/resourcemanager.folderEditor"
  members = [
    "group:test-grp@cloudtuple.com",
  ]
}

# Create hosts and service projects
#-------------------------------
resource "google_project" "netsec_host_project" {
  name = "${var.name}netsec-host-project"
  project_id = "${var.name}netsec-host-project"
  folder_id  = "${google_folder.netsec_folder.name}"
  billing_account = "${var.billing_account_id}"
}

resource "google_project" "prod_service_project" {
  name = "${var.name}prod-service-project"
  project_id = "${var.name}prod-service-project"
  folder_id  = "${google_folder.prod_folder.name}"
  billing_account = "${var.billing_account_id}"
}

resource "google_project" "test_service_project" {
  name = "${var.name}test-service-project"
  project_id = "${var.name}test-service-project"
  folder_id  = "${google_folder.test_folder.name}"
  billing_account = "${var.billing_account_id}"
}

# enable compute service for all service projects
#-------------------------------
resource "google_project_service" "netsec_host_project" {
  project = "${google_project.netsec_host_project.project_id}"
  service = "compute.googleapis.com"
}

resource "google_project_service" "prod_service_project" {
  project = "${google_project.prod_service_project.project_id}"
  service = "compute.googleapis.com"
}

resource "google_project_service" "test_service_project" {
  project = "${google_project.test_service_project.project_id}"
  service = "compute.googleapis.com"
}
