# Top-level folders under an organization
#-------------------------------
resource "google_folder" "gke_folder" {
  display_name = "gke-folder"
  parent     = "organizations/${var.org_id}"
}

# folder iam policy
#-------------------------------
resource "google_folder_iam_policy" "gke_folder" {
  folder  = "${google_folder.gke_folder.name}"
  policy_data = "${data.google_iam_policy.gke_folder_policy.policy_data}"
}

data "google_iam_policy" "gke_folder_policy" {
  binding {
    role = "roles/owner"
    members = [
      "group:gke-grp@cloudtuple.com",
    ]
  }

  binding {
    role    = "roles/resourcemanager.folderAdmin"
    members = [
      "group:gke-grp@cloudtuple.com",
    ]
  }

  binding {
    role    = "roles/resourcemanager.projectCreator"
    members = [
      "group:gke-grp@cloudtuple.com",
    ]
  }
}
