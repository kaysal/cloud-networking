# create bastion instance
resource "google_compute_instance" "bastion" {
  name                      = "${var.name}bastion"
  machine_type              = "g1-small"
  zone                      = "europe-west2-b"
  tags                      = ["bastion", "gce"]
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "projects/debian-cloud/global/images/family/debian-9"
    }
  }

  network_interface {
    subnetwork = "${data.terraform_remote_state.vpc.eu_w2_10_200_20}"
    network_ip = "10.200.20.10"

    access_config {
      // ephemeral nat ip
    }
  }

  metadata {
    ssh-keys = "user:${file("${var.public_key_path}")}"
  }

  metadata_startup_script = "${file("scripts/bastion-startup.sh")}"

  service_account {
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}

resource "google_dns_record_set" "bastion" {
  managed_zone = "${data.google_dns_managed_zone.cloudtuple_public.name}"
  name         = "bastion.orange.${data.google_dns_managed_zone.cloudtuple_public.dns_name}"
  type         = "A"
  ttl          = 300
  rrdatas      = ["${google_compute_instance.bastion.network_interface.0.access_config.0.nat_ip}"]
}
