# create a regional bucket
resource "google_storage_bucket" "bucket" {
  name          = "${data.terraform_remote_state.gke.gke_service_project_id}-w2"
  location      = "europe-west2"
  force_destroy = true
  storage_class = "REGIONAL"
}

# add objects to bucket
resource "google_storage_bucket_object" "picture" {
  name   = "gke-gcs-file"
  source = "./objects/gke-gcs-file.txt"
  bucket = "${google_storage_bucket.bucket.name}"
}

resource "google_storage_bucket_iam_binding" "binding" {
  bucket = "${google_storage_bucket.bucket.name}"
  role   = "roles/storage.objectViewer"

  members = [
    "user:salawu@google.com",
    "serviceAccount:${data.terraform_remote_state.host.vm_host_project_service_account_email}",
    "serviceAccount:${data.terraform_remote_state.apple.vm_apple_service_project_service_account_email}",
    "serviceAccount:${data.terraform_remote_state.orange.vm_orange_project_service_account_email}",
    "serviceAccount:${data.terraform_remote_state.mango.vm_mango_project_service_account_email}",
  ]
}
