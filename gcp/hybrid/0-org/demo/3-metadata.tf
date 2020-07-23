
# prod

resource "google_compute_project_metadata" "prod_metadata" {
  project = google_project.prod_project.project_id
  metadata = {
    x-type         = "StandardVpc"
    ssh-keys       = "user:${file(var.public_key_path)}"
    VmDnsSetting   = "ZonalPreferred"
    enable-oslogin = true
  }
}

# dev

resource "google_compute_project_metadata" "dev_metadata" {
  project = google_project.dev_project.project_id
  metadata = {
    x-type         = "StandardVpc"
    ssh-keys       = "user:${file(var.public_key_path)}"
    VmDnsSetting   = "ZonalPreferred"
    enable-oslogin = true
  }
}

# stage

resource "google_compute_project_metadata" "stage_metadata" {
  project = google_project.stage_project.project_id
  metadata = {
    x-type         = "StandardVpc"
    ssh-keys       = "user:${file(var.public_key_path)}"
    VmDnsSetting   = "ZonalPreferred"
    enable-oslogin = true
  }
}
