# Top-level folders under an organization
#-------------------------------
resource "google_folder" "dev_folder" {
  display_name = "dev-folder"
  parent     = "organizations/${var.org_id}"
}

# folder project owner role to allow authorized groups
# to be project owners on all projects in the folder
#-------------------------------
resource "google_folder_iam_policy" "dev_folder" {
  folder  = "${google_folder.dev_folder.name}"
  policy_data = "${data.google_iam_policy.dev_folder_policy.policy_data}"
}

data "google_iam_policy" "dev_folder_policy" {
  binding {
    role = "roles/owner"
    members = [
      "group:dev-grp@cloudtuple.com",
    ]
  }

  binding {
    role    = "roles/resourcemanager.folderAdmin"
    members = [
      "group:dev-grp@cloudtuple.com",
    ]
  }

  binding {
    role    = "roles/resourcemanager.projectCreator"
    members = [
      "group:dev-grp@cloudtuple.com",
    ]
  }
}
