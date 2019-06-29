# create a regional bucket
resource "google_storage_bucket" "bucket" {
  name          = "${data.terraform_remote_state.gke.outputs.gke_service_project_id}-w1"
  location      = "europe-west1"
  force_destroy = true
  storage_class = "REGIONAL"
}

# add objects to bucket
resource "google_storage_bucket_object" "picture" {
  name   = "gke-gcs-file"
  source = "./objects/gke-gcs-file.txt"
  bucket = google_storage_bucket.bucket.name
}

resource "google_storage_bucket_iam_binding" "binding" {
  bucket = google_storage_bucket.bucket.name
  role   = "roles/storage.objectViewer"

  members = [
    "user:salawu@google.com",
    "serviceAccount:${data.terraform_remote_state.host.outputs.vm_host_project_service_account_email}",
    "serviceAccount:${data.terraform_remote_state.apple.outputs.vm_apple_service_project_service_account_email}",
    "serviceAccount:${data.terraform_remote_state.orange.outputs.vm_orange_project_service_account_email}",
    "serviceAccount:${data.terraform_remote_state.mango.outputs.vm_mango_project_service_account_email}",
  ]
}
