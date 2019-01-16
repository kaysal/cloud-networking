# Top-level folders under an organization
#-------------------------------
resource "google_folder" "prod_folder" {
  display_name = "prod-folder"
  parent     = "organizations/${var.org_id}"
}

# folder project owner role to allow authorized groups
# to be project owners on all projects in the folder
#-------------------------------
resource "google_folder_iam_policy" "prod_folder" {
  folder  = "${google_folder.prod_folder.name}"
  policy_data = "${data.google_iam_policy.prod_folder_policy.policy_data}"
}

data "google_iam_policy" "prod_folder_policy" {
  binding {
    role = "roles/owner"
    members = [
      "group:prod-grp@cloudtuple.com",
    ]
  }

  binding {
    role    = "roles/resourcemanager.folderAdmin"
    members = [
      "group:prod-grp@cloudtuple.com",
    ]
  }

  binding {
    role    = "roles/resourcemanager.projectCreator"
    members = [
      "group:prod-grp@cloudtuple.com",
    ]
  }
}
