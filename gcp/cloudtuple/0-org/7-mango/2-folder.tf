# Top-level folders under an organization
#-------------------------------
resource "google_folder" "mango_folder" {
  display_name = "mango-folder"
  parent     = "organizations/${var.org_id}"
}

# folder project owner role to allow authorized groups
# to be project owners on all projects in the folder
#-------------------------------
resource "google_folder_iam_policy" "mango_folder" {
  folder  = "${google_folder.mango_folder.name}"
  policy_data = "${data.google_iam_policy.mango_folder_policy.policy_data}"
}

data "google_iam_policy" "mango_folder_policy" {
  binding {
    role = "roles/owner"
    members = [
      "group:mango-grp@cloudtuple.com",
    ]
  }

  binding {
    role    = "roles/resourcemanager.folderAdmin"
    members = [
      "group:mango-grp@cloudtuple.com",
    ]
  }

  binding {
    role    = "roles/resourcemanager.projectCreator"
    members = [
      "group:mango-grp@cloudtuple.com",
    ]
  }
}
