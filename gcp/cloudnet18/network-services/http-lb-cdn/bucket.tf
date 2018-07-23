# create a regional bucket in us
resource "google_storage_bucket" "cdn_bucket" {
  name     = "cdn-${var.project_name}"
  location = "us-east1"
  force_destroy = true
  storage_class = "REGIONAL"
}

# add objects to bucket
# 1) cdn.png with public access
# 2) cdn-signed.png with signed url access
resource "google_storage_bucket_object" "cdn_picture" {
  name   = "cdn.png"
  source = "./objects/cdn.png"
  bucket = "${google_storage_bucket.cdn_bucket.name}"
}

resource "google_storage_bucket_object" "cdn_picture_signed" {
  name   = "cdn-signed.png"
  source = "./objects/cdn-signed.png"
  bucket = "${google_storage_bucket.cdn_bucket.name}"
}
