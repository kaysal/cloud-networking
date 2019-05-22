# GCLB Prod IPv4 VIP
resource "google_dns_record_set" "prod" {
  project    = "${data.terraform_remote_state.host.host_project_id}"
  managed_zone = "${data.google_dns_managed_zone.public_host_cloudtuple.name}"
  name         = "gclb.prod.${data.google_dns_managed_zone.public_host_cloudtuple.dns_name}"
  type         = "A"
  ttl          = 300
  rrdatas      = ["${google_compute_global_address.ipv4.address}"]
}

# GCLB Prod IPv6 VIP
resource "google_dns_record_set" "prod6" {
  project    = "${data.terraform_remote_state.host.host_project_id}"
  name         = "gclb6.prod.${data.google_dns_managed_zone.public_host_cloudtuple.dns_name}"
  managed_zone = "${data.google_dns_managed_zone.public_host_cloudtuple.name}"
  type         = "AAAA"
  ttl          = 300
  rrdatas      = ["${google_compute_global_address.ipv6.address}"]
}

# GCLB Dev IPv4 VIP
resource "google_dns_record_set" "dev" {
  project    = "${data.terraform_remote_state.host.host_project_id}"
  managed_zone = "${data.google_dns_managed_zone.public_host_cloudtuple.name}"
  name         = "gclb.dev.${data.google_dns_managed_zone.public_host_cloudtuple.dns_name}"
  type         = "A"
  ttl          = 300
  rrdatas      = ["${google_compute_global_address.ipv4.address}"]
}

# GCLB Dev IPv6 VIP
resource "google_dns_record_set" "dev6" {
  project    = "${data.terraform_remote_state.host.host_project_id}"
  managed_zone = "${data.google_dns_managed_zone.public_host_cloudtuple.name}"
  name         = "gclb6.dev.${data.google_dns_managed_zone.public_host_cloudtuple.dns_name}"
  type         = "AAAA"
  ttl          = 300
  rrdatas      = ["${google_compute_global_address.ipv6.address}"]
}

resource "google_dns_record_set" "neg_eu_w3_vm1" {
  project      = "${data.terraform_remote_state.host.host_project_id}"
  managed_zone = "${data.google_dns_managed_zone.private_apple_cloudtuple.name}"
  name         = "neg1.gclb.${data.google_dns_managed_zone.private_apple_cloudtuple.dns_name}"
  type         = "A"
  ttl          = 300
  rrdatas      = ["${google_compute_instance.neg_eu_w3_vm1.network_interface.0.network_ip}"]
}

resource "google_dns_record_set" "neg_eu_w3_vm2" {
  project      = "${data.terraform_remote_state.host.host_project_id}"
  managed_zone = "${data.google_dns_managed_zone.private_apple_cloudtuple.name}"
  name         = "neg2.gclb.${data.google_dns_managed_zone.private_apple_cloudtuple.dns_name}"
  type         = "A"
  ttl          = 300
  rrdatas      = ["${google_compute_instance.neg_eu_w3_vm2.network_interface.0.network_ip}"]
}

resource "google_dns_record_set" "neg_eu_w3_vm3" {
  project      = "${data.terraform_remote_state.host.host_project_id}"
  managed_zone = "${data.google_dns_managed_zone.private_apple_cloudtuple.name}"
  name         = "neg3.gclb.${data.google_dns_managed_zone.private_apple_cloudtuple.dns_name}"
  type         = "A"
  ttl          = 300
  rrdatas      = ["${google_compute_instance.neg_eu_w3_vm3.network_interface.0.network_ip}"]
}

resource "google_dns_record_set" "sandbox_us_e1_vm" {
  project      = "${data.terraform_remote_state.host.host_project_id}"
  managed_zone = "${data.google_dns_managed_zone.private_apple_cloudtuple.name}"
  name         = "sandbox.gclb.${data.google_dns_managed_zone.private_apple_cloudtuple.dns_name}"
  type         = "A"
  ttl          = 300
  rrdatas      = ["${google_compute_instance.sandbox_us_e1_vm.network_interface.0.network_ip}"]
}
