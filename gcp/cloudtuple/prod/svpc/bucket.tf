resource "random_id" "random" {
  byte_length = 2
}

resource "google_storage_bucket" "prod_storage_bucket" {
  name     = "prod-storage-bucket-${random_id.random.hex}"
  location = "EU"
  force_destroy = true
  storage_class = "MULTI_REGIONAL"
}

# acl to give prod and prod service accounts admin access
# to prod bucket
resource "google_storage_bucket_iam_binding" "service_accounts_to_prod_bucket" {
  bucket = "${google_storage_bucket.prod_storage_bucket.name}"
  role    = "roles/storage.objectAdmin"
  members = [
    "serviceAccount:${data.terraform_remote_state.prod.vm_prod_service_project_service_account_email}",
    "serviceAccount:${data.terraform_remote_state.prod.vm_prod_service_project_service_account_email}",
  ]
}

# acl to give allUsers view access to prod bucket
resource "google_storage_bucket_iam_binding" "allUsers_to_prod_bucket" {
  bucket = "${google_storage_bucket.prod_storage_bucket.name}"
  role    = "roles/storage.objectViewer"
  members = [
    "allUsers",
  ]
}
