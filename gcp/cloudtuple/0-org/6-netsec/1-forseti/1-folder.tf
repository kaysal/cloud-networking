# Top-level folders under an organization
#-------------------------------
resource "google_folder" "netsec_folder" {
  display_name = "netsec-folder"
  parent     = "organizations/${var.org_id}"
}
