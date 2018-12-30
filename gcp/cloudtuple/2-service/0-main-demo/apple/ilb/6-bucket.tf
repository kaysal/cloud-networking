# create a regional bucket in us
resource "google_storage_bucket" "bucket" {
  name          = "${var.project_name}"
  location      = "europe-west1"
  force_destroy = true
  storage_class = "REGIONAL"
}

# add objects to bucket
resource "google_storage_bucket_object" "picture" {
  name   = "9999-layer2.svg"
  source = "./objects/9999-layer2.svg"
  bucket = "${google_storage_bucket.bucket.name}"
}

resource "google_storage_bucket_iam_binding" "binding" {
  bucket = "${google_storage_bucket.bucket.name}"
  role   = "roles/storage.objectViewer"

  members = [
    "allUsers",
  ]
}
