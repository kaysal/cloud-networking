# Top-level folders under an organization
#-------------------------------
resource "google_folder" "test_folder" {
  display_name = "test-folder"
  parent     = "organizations/${var.org_id}"
}

# folder project owner role to allow authorized groups
# to be project owners on all projects in the folder
#-------------------------------
resource "google_folder_iam_policy" "test_folder" {
  folder  = "${google_folder.test_folder.name}"
  policy_data = "${data.google_iam_policy.test_folder_policy.policy_data}"
}

data "google_iam_policy" "test_folder_policy" {
  binding {
    role = "roles/owner"
    members = [
      "group:test-grp@cloudtuple.com",
    ]
  }

  binding {
    role    = "roles/resourcemanager.folderAdmin"
    members = [
      "group:test-grp@cloudtuple.com",
    ]
  }

  binding {
    role    = "roles/resourcemanager.projectCreator"
    members = [
      "group:test-grp@cloudtuple.com",
    ]
  }
}
