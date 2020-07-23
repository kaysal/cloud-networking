
# folders
#==========================================

# level 0
#-----------------------------

resource "google_folder" "fruits" {
  display_name = "fruits"
  parent       = "organizations/${var.org_id}"
}

# level 1
#-----------------------------

resource "google_folder" "apple" {
  display_name = "apple"
  parent       = google_folder.fruits.name
}

resource "google_folder" "orange" {
  display_name = "orange"
  parent       = google_folder.fruits.name
}

resource "google_folder" "mango" {
  display_name = "mango"
  parent       = google_folder.fruits.name
}

# iam
#==========================================

# owner
#-----------------------------

resource "google_folder_iam_member" "folder_owner_apple" {
  folder = google_folder.apple.name
  role   = "roles/owner"
  member = "group:apple-grp@salawu.workshop.ongcp.co"
}

resource "google_folder_iam_member" "folder_owner_orange" {
  folder = google_folder.orange.name
  role   = "roles/owner"
  member = "group:orange-grp@salawu.workshop.ongcp.co"
}

resource "google_folder_iam_member" "folder_owner_mango" {
  folder = google_folder.mango.name
  role   = "roles/owner"
  member = "group:mango-grp@salawu.workshop.ongcp.co"
}

# folder admin
#-----------------------------

resource "google_folder_iam_member" "folder_resource_mgr_apple" {
  folder = google_folder.apple.name
  role   = "roles/resourcemanager.folderAdmin"
  member = "group:apple-grp@salawu.workshop.ongcp.co"
}

resource "google_folder_iam_member" "folder_resource_mgr_orange" {
  folder = google_folder.orange.name
  role   = "roles/resourcemanager.folderAdmin"
  member = "group:orange-grp@salawu.workshop.ongcp.co"
}

resource "google_folder_iam_member" "folder_resource_mgr_mango" {
  folder = google_folder.mango.name
  role   = "roles/resourcemanager.folderAdmin"
  member = "group:mango-grp@salawu.workshop.ongcp.co"
}

# project creator
#-----------------------------

resource "google_folder_iam_member" "folder_project_creator_apple" {
  folder = google_folder.apple.name
  role   = "roles/resourcemanager.projectCreator"
  member = "group:apple-grp@salawu.workshop.ongcp.co"
}

resource "google_folder_iam_member" "folder_project_creator_orange" {
  folder = google_folder.orange.name
  role   = "roles/resourcemanager.projectCreator"
  member = "group:orange-grp@salawu.workshop.ongcp.co"
}

resource "google_folder_iam_member" "folder_project_creator_mango" {
  folder = google_folder.mango.name
  role   = "roles/resourcemanager.projectCreator"
  member = "group:mango-grp@salawu.workshop.ongcp.co"
}

# dns admin
#-----------------------------

resource "google_folder_iam_member" "folder_dns_admin_apple" {
  folder = google_folder.apple.name
  role   = "roles/dns.admin"
  member = "group:apple-grp@salawu.workshop.ongcp.co"
}

resource "google_folder_iam_member" "folder_dns_admin_orange" {
  folder = google_folder.orange.name
  role   = "roles/dns.admin"
  member = "group:orange-grp@salawu.workshop.ongcp.co"
}

resource "google_folder_iam_member" "folder_dns_admin_mango" {
  folder = google_folder.mango.name
  role   = "roles/dns.admin"
  member = "group:mango-grp@salawu.workshop.ongcp.co"
}

# iap https
#-----------------------------

resource "google_folder_iam_member" "folder_https_iap_apple" {
  folder = google_folder.apple.name
  role   = "roles/iap.httpsResourceAccessor"
  member = "group:apple-grp@salawu.workshop.ongcp.co"
}

resource "google_folder_iam_member" "folder_https_iap_orange" {
  folder = google_folder.orange.name
  role   = "roles/iap.httpsResourceAccessor"
  member = "group:orange-grp@salawu.workshop.ongcp.co"
}

resource "google_folder_iam_member" "folder_https_iap_mango" {
  folder = google_folder.mango.name
  role   = "roles/iap.httpsResourceAccessor"
  member = "group:mango-grp@salawu.workshop.ongcp.co"
}
