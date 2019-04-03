# Bastion VPC Network
#==================================
data "template_file" "bastion_main_init" {
  template = "${file("scripts/bastion.sh.tpl")}"

  vars {}
}

resource "google_compute_instance" "bastion" {
  name                      = "${var.main}bastion"
  machine_type              = "f1-micro"
  zone                      = "europe-west1-b"
  tags                      = ["bastion", "gce"]
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    subnetwork = "${google_compute_subnetwork.eu_w1_10_200_20.self_link}"
    network_ip = "10.200.20.253"

    access_config {
      // ephemeral nat ip
    }
  }

  metadata {
    ssh-keys = "user:${file("${var.public_key_path}")}"
  }

  metadata_startup_script = "${data.template_file.bastion_main_init.rendered}"

  service_account {
    scopes = ["cloud-platform"]
    #email  = "${data.terraform_remote_state.orange.vm_orange_project_service_account_email}"
  }
}

resource "google_dns_record_set" "bastion_public" {
  project      = "${data.terraform_remote_state.host.host_project_id}"
  managed_zone = "${data.google_dns_managed_zone.public_host_cloudtuple.name}"
  name         = "bastion.orange.${data.google_dns_managed_zone.public_host_cloudtuple.dns_name}"
  type         = "A"
  ttl          = 300
  rrdatas      = ["${google_compute_instance.bastion.network_interface.0.access_config.0.nat_ip}"]
}

resource "google_dns_record_set" "bastion_private" {
  managed_zone = "${google_dns_managed_zone.private_orange_cloudtuple.name}"
  name         = "bastion.${google_dns_managed_zone.private_orange_cloudtuple.dns_name}"
  type         = "A"
  ttl          = 300
  rrdatas      = ["${google_compute_instance.bastion.network_interface.0.network_ip}"]
}
