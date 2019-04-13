resource "random_id" "suffix" {
  byte_length = 1
}

# LAB 1
#============================
resource "google_project" "student1_lab1" {
  count           = "${var.count}"
  name            = "student${count.index}-${random_id.suffix.hex}-lab1"
  project_id      = "student${count.index}-${random_id.suffix.hex}-lab1"
  org_id          = "${var.org_id}"
  billing_account = "${var.billing_account_id}"
}

resource "google_project_services" "services" {
  count   = "${var.count}"
  project = "student${count.index}-${random_id.suffix.hex}-lab1"

  services = [
    "compute.googleapis.com",
  ]
}
