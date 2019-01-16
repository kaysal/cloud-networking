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
    scopes = ["cloud-platform"]
    email = "${data.terraform_remote_state.orange.vm_orange_project_service_account_email}"
  }
}

resource "google_dns_record_set" "bastion_public" {
  managed_zone = "${data.google_dns_managed_zone.public_orange_cloudtuple.name}"
  name         = "bastion.${data.google_dns_managed_zone.public_orange_cloudtuple.dns_name}"
  type         = "A"
  ttl          = 300
  rrdatas      = ["${google_compute_instance.bastion.network_interface.0.access_config.0.nat_ip}"]
}

resource "google_dns_record_set" "bastion_private" {
  managed_zone = "${data.google_dns_managed_zone.private_orange_cloudtuple.name}"
  name         = "bastion.${data.google_dns_managed_zone.private_orange_cloudtuple.dns_name}"
  type         = "A"
  ttl          = 300
  rrdatas = ["${google_compute_instance.bastion.network_interface.0.address}"]
}
