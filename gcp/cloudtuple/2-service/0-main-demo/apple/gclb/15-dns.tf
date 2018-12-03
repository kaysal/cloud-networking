data "google_dns_managed_zone" "cloudtuple" {
  name = "cloudtuple"
}

# GCLB Prod IPv4 VIP
resource "google_dns_record_set" "prod" {
  managed_zone = "${data.google_dns_managed_zone.cloudtuple.name}"
  name         = "gclb.prod.${data.google_dns_managed_zone.cloudtuple.dns_name}"
  type         = "A"
  ttl          = 300
  rrdatas      = ["${google_compute_global_address.ipv4.address}"]
}

# GCLB Prod IPv6 VIP
resource "google_dns_record_set" "prod6" {
  name         = "gclb6.prod.${data.google_dns_managed_zone.cloudtuple.dns_name}"
  managed_zone = "${data.google_dns_managed_zone.cloudtuple.name}"
  type         = "AAAA"
  ttl          = 300
  rrdatas      = ["${google_compute_global_address.ipv6.address}"]
}

# GCLB Dev IPv4 VIP
resource "google_dns_record_set" "dev" {
  managed_zone = "${data.google_dns_managed_zone.cloudtuple.name}"
  name         = "gclb.dev.${data.google_dns_managed_zone.cloudtuple.dns_name}"
  type         = "A"
  ttl          = 300
  rrdatas      = ["${google_compute_global_address.ipv4.address}"]
}

# GCLB Dev IPv6 VIP
resource "google_dns_record_set" "dev6" {
  managed_zone = "${data.google_dns_managed_zone.cloudtuple.name}"
  name         = "gclb6.dev.${data.google_dns_managed_zone.cloudtuple.dns_name}"
  type         = "AAAA"
  ttl          = 300
  rrdatas      = ["${google_compute_global_address.ipv6.address}"]
}

# Bastion host
resource "google_dns_record_set" "bastion" {
  managed_zone = "${data.google_dns_managed_zone.cloudtuple.name}"
  name         = "gclb.bastion.${data.google_dns_managed_zone.cloudtuple.dns_name}"
  type         = "A"
  ttl          = 300
  rrdatas = ["${google_compute_instance.bastion_eu_w1.network_interface.0.access_config.0.nat_ip}"]
}
