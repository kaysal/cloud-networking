# launch instance into shared VPC
resource "google_compute_instance" "bastion_eu_w1" {
  name         = "${var.name}bastion-eu-w1"
  machine_type = "g1-small"
  zone         = "europe-west1-b"
  tags = ["gce","bastion"]
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "projects/debian-cloud/global/images/family/debian-9"
    }
  }

  network_interface {
    subnetwork = "${data.terraform_remote_state.vpc.apple_eu_w1_10_100_10}"
    network_ip = "10.100.10.88"
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

resource "google_dns_record_set" "bastion" {
  managed_zone = "${data.google_dns_managed_zone.cloudtuple_public.name}"
  name         = "bastion.tcp.${data.google_dns_managed_zone.cloudtuple_public.dns_name}"
  type         = "A"
  ttl          = 300
  rrdatas = ["${google_compute_instance.bastion_eu_w1.network_interface.0.access_config.0.nat_ip}"]
}

resource "google_dns_record_set" "bastion_eu_w1" {
  project    = "${data.terraform_remote_state.host.host_project_id}"
  managed_zone = "${data.google_dns_managed_zone.cloudtuple_private.name}"
  name         = "bastion.tcp.${data.google_dns_managed_zone.cloudtuple_private.dns_name}"
  type         = "A"
  ttl          = 300
  rrdatas = ["${google_compute_instance.bastion_eu_w1.network_interface.0.address}"]
}

output "bastion_eu_w1" {
  value = "${google_compute_instance.bastion_eu_w1.network_interface.0.access_config.0.nat_ip}"
}
