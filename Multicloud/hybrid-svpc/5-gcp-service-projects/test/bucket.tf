resource "random_id" "random" {
  byte_length = 2
}


resource "google_storage_bucket" "test_storage_bucket" {
  name     = "test-storage-bucket-${random_id.random.hex}"
  location = "US"
  force_destroy = true
  storage_class = "MULTI_REGIONAL"
}

# acl to allow test and prod account access to test project storage bucket
# all instances have cloud-pltform scope
resource "google_storage_bucket_iam_binding" "prod_bucket_editor" {
  bucket = "${google_storage_bucket.test_storage_bucket.name}"
  role    = "roles/storage.objectAdmin"
  members = [
    "serviceAccount:${data.terraform_remote_state.iam.instance_prod_service_project_service_account_email}",
    "serviceAccount:${data.terraform_remote_state.iam.instance_test_service_project_service_account_email}",
  ]
}
