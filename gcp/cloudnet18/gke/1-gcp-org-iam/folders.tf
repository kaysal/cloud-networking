# Top-level folders under an organization
#-------------------------------
resource "google_folder" "host_folder" {
  display_name = "${var.name}host-folder"
  parent     = "organizations/${var.org_id}"
}

resource "google_folder" "service_folder" {
  display_name = "${var.name}service-folder"
  parent     = "organizations/${var.org_id}"
}

# folder project owner role to allow authorized groups
# to be project owners on all projects in the folder
#-------------------------------
resource "google_folder_iam_policy" "host_folder" {
  folder  = "${google_folder.host_folder.name}"
  policy_data = "${data.google_iam_policy.host_folder_policy.policy_data}"
}

data "google_iam_policy" "host_folder_policy" {
  binding {
    role = "roles/owner"
    members = [
      "group:netsec-grp@cloudtuple.com",
    ]
  }

  binding {
    role    = "roles/resourcemanager.folderEditor"
    members = [
      "group:netsec-grp@cloudtuple.com",
    ]
  }
}

resource "google_folder_iam_policy" "service_folder" {
  folder  = "${google_folder.service_folder.name}"
  policy_data = "${data.google_iam_policy.service_folder_policy.policy_data}"
}

data "google_iam_policy" "service_folder_policy" {
  binding {
    role = "roles/owner"
    members = [
      "group:prod-grp@cloudtuple.com",
    ]
  }

  binding {
    role    = "roles/resourcemanager.folderEditor"
    members = [
      "group:prod-grp@cloudtuple.com",
    ]
  }
}
