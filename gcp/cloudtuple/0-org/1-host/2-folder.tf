# Top-level folders under an organization
#-------------------------------
resource "google_folder" "host_folder" {
  display_name = "host-folder"
  parent       = "organizations/${var.org_id}"
}

# folder project owner role to allow authorized groups
# to be project owners on all projects in the folder
#-------------------------------
resource "google_folder_iam_member" "folder_owner_netsec" {
  folder = "${google_folder.host_folder.name}"
  role   = "roles/owner"
  member = "group:netsec-grp@cloudtuple.com"
}

resource "google_folder_iam_member" "folder_resource_mgr_netsec" {
  folder = "${google_folder.host_folder.name}"
  role   = "roles/resourcemanager.folderAdmin"
  member = "group:netsec-grp@cloudtuple.com"
}

resource "google_folder_iam_member" "folder_project_creator_netsec" {
  folder = "${google_folder.host_folder.name}"
  role   = "roles/resourcemanager.projectCreator"
  member = "group:netsec-grp@cloudtuple.com"
}
