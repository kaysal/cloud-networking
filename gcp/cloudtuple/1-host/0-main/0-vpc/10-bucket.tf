# create a regional bucket in europe-west1
resource "google_storage_bucket" "bucket" {
  name          = "${data.terraform_remote_state.host.host_project_id}"
  location      = "europe-west1"
  force_destroy = true
  storage_class = "REGIONAL"
}

# add objects to bucket
resource "google_storage_bucket_object" "file" {
  name   = "host-project-gcs-file.txt"
  source = "./objects/host-project-gcs-file.txt"
  bucket = "${google_storage_bucket.bucket.name}"
}

/*
# acl to give prod and prod service accounts admin access
# to prod bucket
#-----------------------------------
resource "google_storage_bucket_iam_binding" "service_accounts_access_to_host_bucket" {
  bucket = "${google_storage_bucket.bucket.name}"
  role   = "roles/storage.objectAdmin"

  members = [
    "serviceAccount:${data.terraform_remote_state.host.vm_host_project_service_account_email}",
    "serviceAccount:${data.terraform_remote_state.host.tf_host_project_service_account_email}",
  ]
}

# acl to give allUsers view access to prod bucket
resource "google_storage_bucket_iam_binding" "binding" {
  bucket = "${google_storage_bucket.bucket.name}"
  role   = "roles/storage.objectViewer"

  members = [
    "user:salawu@google.com",
    "serviceAccount:${data.terraform_remote_state.apple.vm_apple_service_project_service_account_email}",
    "serviceAccount:${data.terraform_remote_state.orange.vm_orange_project_service_account_email}",
    "serviceAccount:${data.terraform_remote_state.mango.vm_mango_project_service_account_email}",
  ]
}*/

# create a multi-regional bucket in europe-west1
# to store google project usage reports
#-----------------------------------
resource "google_storage_bucket" "bucket_usage_export" {
  name          = "${data.terraform_remote_state.host.host_project_id}-usage-export"
  location      = "EU"
  force_destroy = true
  storage_class = "MULTI_REGIONAL"
}

resource "google_project_usage_export_bucket" "usage_export" {
  project     = "${data.terraform_remote_state.host.host_project_id}"
  bucket_name = "${google_storage_bucket.bucket_usage_export.name}"
}