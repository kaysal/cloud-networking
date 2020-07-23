
resource "google_storage_bucket" "spoke2_bucket" {
  project       = var.project_id_spoke2
  name          = "${var.global.prefix}${var.project_id_spoke2}"
  location      = var.spoke2.region
  force_destroy = true
  storage_class = "REGIONAL"
}

resource "google_storage_bucket_object" "spoke2_file" {
  name   = "spoke2.txt"
  source = "./objects/spoke2.txt"
  bucket = google_storage_bucket.spoke2_bucket.name
}

# acl

resource "google_storage_bucket_iam_binding" "spoke2_binding" {
  bucket = google_storage_bucket.spoke2_bucket.name
  role   = "roles/storage.objectViewer"

  members = [
    "serviceAccount:${local.sa.spoke1.email}",
    "serviceAccount:${local.sa.spoke2.email}",
  ]
}
