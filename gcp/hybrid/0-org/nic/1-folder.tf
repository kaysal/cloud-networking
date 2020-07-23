
# folders
#---------------------------------------

# top

resource "google_folder" "nic" {
  display_name = "nic"
  parent       = "organizations/${var.org_id}"
}

# level 1

resource "google_folder" "hub" {
  display_name = "hub"
  parent       = google_folder.nic.name
}

resource "google_folder" "spokes" {
  display_name = "spokes"
  parent       = google_folder.nic.name
}
