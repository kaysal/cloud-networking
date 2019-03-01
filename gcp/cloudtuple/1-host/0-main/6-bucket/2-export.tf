resource "google_project_usage_export_bucket" "usage_export" {
  project = "${data.terraform_remote_state.host.host_project_id}"
  bucket_name  = "${google_storage_bucket.bucket_usage_export.name}"
}
