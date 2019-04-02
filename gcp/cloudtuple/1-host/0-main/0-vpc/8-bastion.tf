# Bastion host
#============================
data "template_file" "bastion_init" {
  template = "${file("scripts/bastion.sh.tpl")}"

  vars {}
}

resource "google_compute_instance" "bastion" {
  name                      = "${var.name}bastion-eu-w1"
  machine_type              = "f1-micro"
  zone                      = "europe-west1-b"
  tags                      = ["gce", "bastion"]
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    subnetwork = "${google_compute_subnetwork.apple_eu_w1_10_100_10.self_link}"
    network_ip = "10.100.10.253"

    access_config {
      // ephemeral nat ip
    }
  }

  metadata_startup_script = "${data.template_file.bastion_init.rendered}"

  service_account {
    scopes = ["cloud-platform"]
  }
}

resource "google_dns_record_set" "bastion_public" {
  managed_zone = "${google_dns_managed_zone.public_host_cloudtuple.name}"
  name         = "bastion.host.${google_dns_managed_zone.public_host_cloudtuple.dns_name}"
  type         = "A"
  ttl          = 300
  rrdatas      = ["${google_compute_instance.bastion.network_interface.0.access_config.0.nat_ip}"]
}

resource "google_dns_record_set" "bastion_private" {
  project      = "${data.terraform_remote_state.host.host_project_id}"
  managed_zone = "${google_dns_managed_zone.private_host_cloudtuple.name}"
  name         = "bastion.${google_dns_managed_zone.private_host_cloudtuple.dns_name}"
  type         = "A"
  ttl          = 300
  rrdatas      = ["${google_compute_instance.bastion.network_interface.0.network_ip}"]
}
