provider "google" {}

provider "google-beta" {}

locals {
  users          = 2
  rand           = "netz"
  prefix         = "user"
  offset         = 1
  vpc_demo_asn   = 64514
  vpc_onprem_asn = 64515
}

# Folder containing a user's projects
#-------------------------------
resource "google_folder" "folder" {
  count        = "${local.users}"
  display_name = "${local.rand}-${local.prefix}${count.index + local.offset}-folder"
  parent       = "organizations/${var.org_id}"

  lifecycle {
    ignore_changes = "all"
  }
}

# Grant user necessary folder permissions
#-------------------------------
resource "google_folder_iam_member" "folder_owner" {
  count  = "${local.users}"
  folder = "${element(google_folder.folder.*.name, count.index)}"
  role   = "roles/owner"
  member = "user:${local.prefix}${count.index + local.offset}@cloudtuple.com"

  lifecycle {
    ignore_changes = "all"
  }
}

resource "google_folder_iam_member" "folder_resource_mgr" {
  count  = "${local.users}"
  folder = "${element(google_folder.folder.*.name, count.index)}"
  role   = "roles/resourcemanager.folderAdmin"
  member = "user:${local.prefix}${count.index + local.offset}@cloudtuple.com"

  lifecycle {
    ignore_changes = "all"
  }
}

resource "google_folder_iam_member" "folder_project_creator" {
  count  = "${local.users}"
  folder = "${element(google_folder.folder.*.name, count.index)}"
  role   = "roles/resourcemanager.projectCreator"
  member = "user:${local.prefix}${count.index + local.offset}@cloudtuple.com"

  lifecycle {
    ignore_changes = "all"
  }
}

#============================================
# COMPLETE LAB
#============================================
# Create Lab Project under each user's folder
#----------------------------------------
resource "google_project" "labs" {
  count           = "${local.users}"
  name            = "${local.rand}-user${count.index + local.offset}-labs"
  folder_id       = "${element(google_folder.folder.*.name, count.index)}"
  project_id      = "${local.rand}-user${count.index + local.offset}-labs"
  billing_account = "${var.billing_account_id}"

  lifecycle {
    ignore_changes = "all"
  }
}

resource "google_project_services" "labs" {
  count   = "${local.users}"
  project = "${local.rand}-user${count.index + local.offset}-labs"

  services = [
    "compute.googleapis.com",
    "oslogin.googleapis.com",
  ]

  lifecycle {
    ignore_changes = "all"
  }

  depends_on = ["google_project.labs"]
}
