# project metadata
#----------------------------------------------------
resource "google_compute_project_metadata" "host_project_metadata" {
  project = "${google_project.orange_project.project_id}"
  metadata = {
    x-type  = "StandardVpc"
    ssh-keys = "user:${file("${var.public_key_path}")}"
    VmDnsSetting = "ZonalPreferred"
    enable-oslogin = true
  }
}
