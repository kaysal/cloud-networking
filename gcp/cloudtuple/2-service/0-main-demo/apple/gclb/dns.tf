# dns zones
resource "google_dns_managed_zone" "prod" {
  name        = "prod-zone"
  dns_name    = "prod.cloudtuple.com."
  description = "Prod DNS zone"
}

resource "google_dns_managed_zone" "dev" {
  name        = "dev-zone"
  dns_name    = "dev.cloudtuple.com."
  description = "Dev DNS zone"
}

# dns record sets
resource "google_dns_record_set" "prod_ipv4" {
  name = "${google_dns_managed_zone.prod.dns_name}"
  managed_zone = "${google_dns_managed_zone.prod.name}"
  type = "A"
  ttl  = 300

  rrdatas = ["${google_compute_global_address.gclb_ipv4.address}"]
}

# dns record sets
resource "google_dns_record_set" "prod_ipv6" {
  name = "v6.${google_dns_managed_zone.prod.dns_name}"
  managed_zone = "${google_dns_managed_zone.prod.name}"
  type = "AAAA"
  ttl  = 300

  rrdatas = ["${google_compute_global_address.gclb_ipv6.address}"]
}

# dns record sets
resource "google_dns_record_set" "dev_ipv4" {
  name = "${google_dns_managed_zone.dev.dns_name}"
  managed_zone = "${google_dns_managed_zone.dev.name}"
  type = "A"
  ttl  = 300

  rrdatas = ["${google_compute_global_address.gclb_ipv4.address}"]
}

# dns record sets
resource "google_dns_record_set" "dev_ipv6" {
  name = "v6.${google_dns_managed_zone.dev.dns_name}"
  managed_zone = "${google_dns_managed_zone.dev.name}"
  type = "AAAA"
  ttl  = 300

  rrdatas = ["${google_compute_global_address.gclb_ipv6.address}"]
}
