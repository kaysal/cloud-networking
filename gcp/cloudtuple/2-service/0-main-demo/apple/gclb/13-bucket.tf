# create a regional bucket in europe-west1
resource "google_storage_bucket" "bucket" {
  name          = "${var.project_name}-gclb"
  location      = "europe-west1"
  force_destroy = true
  storage_class = "REGIONAL"
}

# add objects to bucket
resource "google_storage_bucket_object" "file" {
  name   = "apple-service-project-gcs-bucket-file.txt"
  source = "./objects/apple-service-project-gcs-bucket-file.txt"
  bucket = "${google_storage_bucket.bucket.name}"
}

# acl to give prod and prod service accounts admin access
# to prod bucket
resource "google_storage_bucket_iam_binding" "service_accounts_access_to_apple_bucket" {
  bucket = "${google_storage_bucket.bucket.name}"
  role   = "roles/storage.objectAdmin"

  members = [
    "serviceAccount:${data.terraform_remote_state.apple.vm_apple_service_project_service_account_email}",
  ]
}
/*
# acl to give allUsers view access to prod bucket
resource "google_storage_bucket_iam_binding" "binding" {
  bucket = "${google_storage_bucket.bucket.name}"
  role   = "roles/storage.objectViewer"

  members = [
    "allUsers",
  ]
}*/
