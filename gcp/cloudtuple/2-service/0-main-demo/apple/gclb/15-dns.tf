data "google_dns_managed_zone" "cloudtuple_public" {
  name = "cloudtuple"
}

data "google_dns_managed_zone" "cloudtuple_private" {
  project    = "${data.terraform_remote_state.host.host_project_id}"
  name        = "cloudtuple-private"
}


# GCLB Prod IPv4 VIP
resource "google_dns_record_set" "prod" {
  managed_zone = "${data.google_dns_managed_zone.cloudtuple_public.name}"
  name         = "gclb.prod.${data.google_dns_managed_zone.cloudtuple_public.dns_name}"
  type         = "A"
  ttl          = 300
  rrdatas      = ["${google_compute_global_address.ipv4.address}"]
}

# GCLB Prod IPv6 VIP
resource "google_dns_record_set" "prod6" {
  name         = "gclb6.prod.${data.google_dns_managed_zone.cloudtuple_public.dns_name}"
  managed_zone = "${data.google_dns_managed_zone.cloudtuple_public.name}"
  type         = "AAAA"
  ttl          = 300
  rrdatas      = ["${google_compute_global_address.ipv6.address}"]
}

# GCLB Dev IPv4 VIP
resource "google_dns_record_set" "dev" {
  managed_zone = "${data.google_dns_managed_zone.cloudtuple_public.name}"
  name         = "gclb.dev.${data.google_dns_managed_zone.cloudtuple_public.dns_name}"
  type         = "A"
  ttl          = 300
  rrdatas      = ["${google_compute_global_address.ipv4.address}"]
}

# GCLB Dev IPv6 VIP
resource "google_dns_record_set" "dev6" {
  managed_zone = "${data.google_dns_managed_zone.cloudtuple_public.name}"
  name         = "gclb6.dev.${data.google_dns_managed_zone.cloudtuple_public.dns_name}"
  type         = "AAAA"
  ttl          = 300
  rrdatas      = ["${google_compute_global_address.ipv6.address}"]
}
