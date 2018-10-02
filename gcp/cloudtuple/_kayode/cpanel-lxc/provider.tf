
provider "google" {
  project    = "${var.project_name}"
  credentials = "${var.credentials_file_path}"
}
