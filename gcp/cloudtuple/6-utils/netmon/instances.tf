resource "google_compute_instance" "netmon" {
  count = "${length(var.list_of_regions)}"
  name  = "${var.name}${var.list_of_region_names[count.index]}"
  machine_type = "n1-standard-1"
  zone = "${var.list_of_regions[count.index]}-b"
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "projects/debian-cloud/global/images/family/debian-9"
    }
  }

  network_interface {
    network = "default"
    access_config {
      // ephemeral nat ip
    }
  }

  metadata {
    ssh-keys = "user:${file("${var.public_key_path}")}"
  }

  metadata_startup_script = "${file("scripts/script.sh")}"

  service_account {
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}
