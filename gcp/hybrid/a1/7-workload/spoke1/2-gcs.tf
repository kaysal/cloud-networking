
resource "google_storage_bucket" "spoke1_bucket" {
  project       = var.project_id_spoke1
  name          = "${var.global.prefix}${var.project_id_spoke1}"
  location      = var.spoke1.region
  force_destroy = true
  storage_class = "REGIONAL"
}

resource "google_storage_bucket_object" "spoke1_file" {
  name   = "spoke1.txt"
  source = "./objects/spoke1.txt"
  bucket = google_storage_bucket.spoke1_bucket.name
}

# acl

resource "google_storage_bucket_iam_binding" "spoke1_binding" {
  bucket = google_storage_bucket.spoke1_bucket.name
  role   = "roles/storage.objectViewer"

  members = [
    "serviceAccount:${local.sa.spoke1.email}",
    "serviceAccount:${local.sa.spoke2.email}",
  ]
}
