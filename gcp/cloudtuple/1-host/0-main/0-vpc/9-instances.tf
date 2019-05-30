module "bastion" {
  source                = "github.com/kaysal/modules.git//gcp/bastion"
  name                  = "${var.env}bastion"
  hostname              = "bastion.host.cloudtuple.com"
  project               = "${data.terraform_remote_state.host.host_project_id}"
  network_project       = "${data.terraform_remote_state.host.host_project_id}"
  network               = "${google_compute_network.vpc.self_link}"
  subnetwork            = "${google_compute_subnetwork.apple_eu_w1_10_100_10.self_link}"
  zone                  = "europe-west1-c"
  service_account_email = "${data.terraform_remote_state.host.vm_host_project_service_account_email}"

  #machine_type             = "f1-micro"
  #list_of_tags             = ["bastion", "gce"]
  #image                    = "debian-cloud/debian-9"
  #disk_type                = "pd-standard"
  #disk_size                = "10"
}

resource "google_dns_record_set" "bastion_public" {
  managed_zone = "${google_dns_managed_zone.public_host_cloudtuple.name}"
  name         = "bastion.host.${google_dns_managed_zone.public_host_cloudtuple.dns_name}"
  type         = "A"
  ttl          = 300
  rrdatas      = ["${module.bastion.bastion_nat_ip}"]
}

resource "google_dns_record_set" "bastion_private" {
  project      = "${data.terraform_remote_state.host.host_project_id}"
  managed_zone = "${google_dns_managed_zone.private_host_cloudtuple.name}"
  name         = "bastion.${google_dns_managed_zone.private_host_cloudtuple.dns_name}"
  type         = "A"
  ttl          = 300
  rrdatas      = ["${module.bastion.bastion_private_ip}"]
}

# web server

resource "google_compute_instance" "web" {
  name                      = "${var.env}web"
  machine_type              = "f1-micro"
  zone                      = "europe-west1-b"
  tags                      = ["gce", "mig"]
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "projects/debian-cloud/global/images/family/debian-9"
    }
  }

  network_interface {
    subnetwork = "${google_compute_subnetwork.apple_eu_w1_10_100_10.self_link}"
    network_ip = "10.100.10.101"
  }

  metadata_startup_script = "${file("scripts/web.sh")}"

  service_account {
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}
