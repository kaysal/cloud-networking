# Top-level folders under an organization
#-------------------------------
resource "google_folder" "gke_folder" {
  display_name = "gke-folder"
  parent       = "organizations/${var.org_id}"
}

# folder iam policy
#-------------------------------
resource "google_folder_iam_member" "folder_owner_gke" {
  folder = "${google_folder.gke_folder.name}"
  role   = "roles/owner"
  member = "group:gke-grp@cloudtuple.com"
}

resource "google_folder_iam_member" "folder_resource_mgr_gke" {
  folder = "${google_folder.gke_folder.name}"
  role   = "roles/resourcemanager.folderAdmin"
  member = "group:gke-grp@cloudtuple.com"
}

resource "google_folder_iam_member" "folder_project_creator_gke" {
  folder = "${google_folder.gke_folder.name}"
  role   = "roles/resourcemanager.projectCreator"
  member = "group:gke-grp@cloudtuple.com"
}
