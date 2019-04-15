provider "google" {}

provider "google-beta" {}

locals {
  count          = 2
  rand           = "man"
  prefix         = "user"
  offset         = 1
  vpc_asn        = 64514
  vpc_onprem_asn = 64515
}

# Folder containing a user's projects
#-------------------------------
resource "google_folder" "folder" {
  count        = "${local.count}"
  display_name = "${local.rand}-${local.prefix}${count.index + local.offset}-folder"
  parent       = "organizations/${var.org_id}"
}

# Grant user necessary folder permissions
#-------------------------------
resource "google_folder_iam_member" "folder_owner" {
  count  = "${local.count}"
  folder = "${element(google_folder.folder.*.name, count.index)}"
  role   = "roles/owner"
  member = "user:${local.prefix}${count.index + local.offset}@cloudtuple.com"
}

resource "google_folder_iam_member" "folder_resource_mgr" {
  count  = "${local.count}"
  folder = "${element(google_folder.folder.*.name, count.index)}"
  role   = "roles/resourcemanager.folderAdmin"
  member = "user:${local.prefix}${count.index + local.offset}@cloudtuple.com"
}

resource "google_folder_iam_member" "folder_project_creator" {
  count  = "${local.count}"
  folder = "${element(google_folder.folder.*.name, count.index)}"
  role   = "roles/resourcemanager.projectCreator"
  member = "user:${local.prefix}${count.index + local.offset}@cloudtuple.com"
}
