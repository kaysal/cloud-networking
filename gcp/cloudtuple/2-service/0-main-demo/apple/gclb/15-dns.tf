data "google_dns_managed_zone" "public_host_cloudtuple" {
  project    = "${data.terraform_remote_state.host.host_project_id}"
  name        = "public-host-cloudtuple"
}

data "google_dns_managed_zone" "private_apple_cloudtuple" {
  project = "${data.terraform_remote_state.host.host_project_id}"
  name    = "private-apple-cloudtuple"
}

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
