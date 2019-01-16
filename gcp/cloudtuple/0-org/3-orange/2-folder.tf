# Top-level folders under an organization
#-------------------------------
resource "google_folder" "orange_folder" {
  display_name = "orange-folder"
  parent     = "organizations/${var.org_id}"
}

# folder project owner role to allow authorized groups
# to be project owners on all projects in the folder
#-------------------------------
resource "google_folder_iam_member" "folder_owner_orange" {
  folder  = "${google_folder.orange_folder.name}"
  role    = "roles/owner"
  member  = "group:orange-grp@cloudtuple.com"
}

resource "google_folder_iam_member" "folder_resource_mgr_orange" {
  folder  = "${google_folder.orange_folder.name}"
  role    = "roles/resourcemanager.folderAdmin"
  member  = "group:orange-grp@cloudtuple.com"
}

resource "google_folder_iam_member" "folder_project_creator_orange" {
  folder  = "${google_folder.orange_folder.name}"
  role    = "roles/resourcemanager.projectCreator"
  member  = "group:orange-grp@cloudtuple.com"
}
