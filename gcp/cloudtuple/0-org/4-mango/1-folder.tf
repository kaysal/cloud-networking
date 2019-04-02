# Top-level folders under an organization
#-------------------------------
resource "google_folder" "mango_folder" {
  display_name = "mango-folder"
  parent     = "organizations/${var.org_id}"
}

# folder project owner role to allow authorized groups
# to be project owners on all projects in the folder
#-------------------------------
resource "google_folder_iam_member" "folder_owner_mango" {
  folder  = "${google_folder.mango_folder.name}"
  role    = "roles/owner"
  member  = "group:mango-grp@cloudtuple.com"
}

resource "google_folder_iam_member" "folder_resource_mgr_mango" {
  folder  = "${google_folder.mango_folder.name}"
  role    = "roles/resourcemanager.folderAdmin"
  member  = "group:mango-grp@cloudtuple.com"
}

resource "google_folder_iam_member" "folder_project_creator_mango" {
  folder  = "${google_folder.mango_folder.name}"
  role    = "roles/resourcemanager.projectCreator"
  member  = "group:mango-grp@cloudtuple.com"
}
