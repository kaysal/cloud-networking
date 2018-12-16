data "google_dns_managed_zone" "cloudtuple_public" {
  name = "cloudtuple"
}

data "google_dns_managed_zone" "cloudtuple_private" {
  project    = "${data.terraform_remote_state.host.host_project_id}"
  name        = "cloudtuple-private"
}

# TCP IPv4 VIP
resource "google_dns_record_set" "nlb" {
  managed_zone = "${data.google_dns_managed_zone.cloudtuple_public.name}"
  name         = "nlb.${data.google_dns_managed_zone.cloudtuple_public.dns_name}"
  type         = "A"
  ttl          = 300
  rrdatas      = ["${google_compute_address.ipv4.address}"]
}
