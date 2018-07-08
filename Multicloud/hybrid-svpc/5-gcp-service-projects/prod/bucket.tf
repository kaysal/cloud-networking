resource "random_id" "random" {
  byte_length = 2
}


resource "google_storage_bucket" "prod_storage_bucket" {
  name     = "prod-storage-bucket-${random_id.random.hex}"
  location = "US"
  force_destroy = true
  storage_class = "MULTI_REGIONAL"
}

# acl to allow test account access to prod project storage bucket
# test account instances have cloud-pltform scope
resource "google_storage_bucket_iam_binding" "test_bucket_editor" {
  bucket = "${google_storage_bucket.prod_storage_bucket.name}"
  role    = "roles/storage.objectAdmin"
  members = [
    "serviceAccount:${data.terraform_remote_state.iam.instance_test_service_project_service_account_email}",
  ]
}
