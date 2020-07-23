
# folders
#---------------------------------------

# top

resource "google_folder" "salawu" {
  display_name = "salawu"
  parent       = "organizations/${var.org_id}"
}

# level 1

resource "google_folder" "onprem" {
  display_name = "onprem"
  parent       = google_folder.salawu.name
}

resource "google_folder" "hub" {
  display_name = "hub"
  parent       = google_folder.salawu.name
}

resource "google_folder" "spokes" {
  display_name = "spokes"
  parent       = google_folder.salawu.name
}
