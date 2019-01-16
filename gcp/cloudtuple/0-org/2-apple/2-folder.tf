# Top-level folders under an organization
#-------------------------------
resource "google_folder" "apple_folder" {
  display_name = "apple-folder"
  parent     = "organizations/${var.org_id}"
}

# folder project owner role to allow authorized groups
# to be project owners on all projects in the folder
#-------------------------------
resource "google_folder_iam_member" "folder_owner_apple" {
  folder  = "${google_folder.apple_folder.name}"
  role    = "roles/owner"
  member  = "group:apple-grp@cloudtuple.com"
}

resource "google_folder_iam_member" "folder_resource_mgr_apple" {
  folder  = "${google_folder.apple_folder.name}"
  role    = "roles/resourcemanager.folderAdmin"
  member  = "group:apple-grp@cloudtuple.com"
}

resource "google_folder_iam_member" "folder_project_creator_apple" {
  folder  = "${google_folder.apple_folder.name}"
  role    = "roles/resourcemanager.projectCreator"
  member  = "group:apple-grp@cloudtuple.com"
}
