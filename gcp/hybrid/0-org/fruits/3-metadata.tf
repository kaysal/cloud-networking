
# apple

resource "google_compute_project_metadata" "apple_metadata" {
  project = google_project.apple_project.project_id
  metadata = {
    x-type         = "StandardVpc"
    ssh-keys       = "user:${file(var.public_key_path)}"
    VmDnsSetting   = "ZonalPreferred"
    enable-oslogin = true
  }
}

# orange

resource "google_compute_project_metadata" "orange_metadata" {
  project = google_project.orange_project.project_id
  metadata = {
    x-type         = "StandardVpc"
    ssh-keys       = "user:${file(var.public_key_path)}"
    VmDnsSetting   = "ZonalPreferred"
    enable-oslogin = true
  }
}

# mango

resource "google_compute_project_metadata" "mango_metadata" {
  project = google_project.mango_project.project_id
  metadata = {
    x-type         = "StandardVpc"
    ssh-keys       = "user:${file(var.public_key_path)}"
    VmDnsSetting   = "ZonalPreferred"
    enable-oslogin = true
  }
}
