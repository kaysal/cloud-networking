
# onprem

resource "google_compute_project_metadata" "onprem_metadata" {
  project = google_project.onprem_project.project_id
  metadata = {
    x-type         = "StandardVpc"
    ssh-keys       = "user:${file(var.public_key_path)}"
    VmDnsSetting   = "ZonalPreferred"
    enable-oslogin = true
  }
}

# hub

resource "google_compute_project_metadata" "hub_metadata" {
  project = google_project.hub_project.project_id
  metadata = {
    x-type         = "StandardVpc"
    ssh-keys       = "user:${file(var.public_key_path)}"
    VmDnsSetting   = "ZonalPreferred"
    enable-oslogin = true
  }
}

# spoke1

resource "google_compute_project_metadata" "spoke1_metadata" {
  project = google_project.spoke1_project.project_id
  metadata = {
    x-type         = "StandardVpc"
    ssh-keys       = "user:${file(var.public_key_path)}"
    VmDnsSetting   = "ZonalPreferred"
    enable-oslogin = true
  }
}

# spoke2

resource "google_compute_project_metadata" "spoke2_metadata" {
  project = google_project.spoke2_project.project_id
  metadata = {
    x-type         = "StandardVpc"
    ssh-keys       = "user:${file(var.public_key_path)}"
    VmDnsSetting   = "ZonalPreferred"
    enable-oslogin = true
  }
}
