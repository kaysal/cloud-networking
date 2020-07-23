
# folders
#==========================================

# level 0
#-----------------------------

resource "google_folder" "demo" {
  display_name = "demo"
  parent       = "organizations/${var.org_id}"
}

# level 1
#-----------------------------

resource "google_folder" "prod" {
  display_name = "prod"
  parent       = google_folder.demo.name
}

resource "google_folder" "dev" {
  display_name = "dev"
  parent       = google_folder.demo.name
}

resource "google_folder" "stage" {
  display_name = "stage"
  parent       = google_folder.demo.name
}

# iam
#==========================================

# owner
#-----------------------------

resource "google_folder_iam_member" "folder_owner_prod" {
  folder = google_folder.prod.name
  role   = "roles/owner"
  member = "group:prod-grp@salawu.workshop.ongcp.co"
}

resource "google_folder_iam_member" "folder_owner_dev" {
  folder = google_folder.dev.name
  role   = "roles/owner"
  member = "group:dev-grp@salawu.workshop.ongcp.co"
}

resource "google_folder_iam_member" "folder_owner_stage" {
  folder = google_folder.stage.name
  role   = "roles/owner"
  member = "group:stage-grp@salawu.workshop.ongcp.co"
}

# folder admin
#-----------------------------

resource "google_folder_iam_member" "folder_resource_mgr_prod" {
  folder = google_folder.prod.name
  role   = "roles/resourcemanager.folderAdmin"
  member = "group:prod-grp@salawu.workshop.ongcp.co"
}

resource "google_folder_iam_member" "folder_resource_mgr_dev" {
  folder = google_folder.dev.name
  role   = "roles/resourcemanager.folderAdmin"
  member = "group:dev-grp@salawu.workshop.ongcp.co"
}

resource "google_folder_iam_member" "folder_resource_mgr_stage" {
  folder = google_folder.stage.name
  role   = "roles/resourcemanager.folderAdmin"
  member = "group:stage-grp@salawu.workshop.ongcp.co"
}

# project creator
#-----------------------------

resource "google_folder_iam_member" "folder_project_creator_prod" {
  folder = google_folder.prod.name
  role   = "roles/resourcemanager.projectCreator"
  member = "group:prod-grp@salawu.workshop.ongcp.co"
}

resource "google_folder_iam_member" "folder_project_creator_dev" {
  folder = google_folder.dev.name
  role   = "roles/resourcemanager.projectCreator"
  member = "group:dev-grp@salawu.workshop.ongcp.co"
}

resource "google_folder_iam_member" "folder_project_creator_stage" {
  folder = google_folder.stage.name
  role   = "roles/resourcemanager.projectCreator"
  member = "group:stage-grp@salawu.workshop.ongcp.co"
}

# dns admin
#-----------------------------

resource "google_folder_iam_member" "folder_dns_admin_prod" {
  folder = google_folder.prod.name
  role   = "roles/dns.admin"
  member = "group:prod-grp@salawu.workshop.ongcp.co"
}

resource "google_folder_iam_member" "folder_dns_admin_dev" {
  folder = google_folder.dev.name
  role   = "roles/dns.admin"
  member = "group:dev-grp@salawu.workshop.ongcp.co"
}

resource "google_folder_iam_member" "folder_dns_admin_stage" {
  folder = google_folder.stage.name
  role   = "roles/dns.admin"
  member = "group:stage-grp@salawu.workshop.ongcp.co"
}

# iap https
#-----------------------------

resource "google_folder_iam_member" "folder_https_iap_prod" {
  folder = google_folder.prod.name
  role   = "roles/iap.httpsResourceAccessor"
  member = "group:prod-grp@salawu.workshop.ongcp.co"
}

resource "google_folder_iam_member" "folder_https_iap_dev" {
  folder = google_folder.dev.name
  role   = "roles/iap.httpsResourceAccessor"
  member = "group:dev-grp@salawu.workshop.ongcp.co"
}

resource "google_folder_iam_member" "folder_https_iap_stage" {
  folder = google_folder.stage.name
  role   = "roles/iap.httpsResourceAccessor"
  member = "group:stage-grp@salawu.workshop.ongcp.co"
}
