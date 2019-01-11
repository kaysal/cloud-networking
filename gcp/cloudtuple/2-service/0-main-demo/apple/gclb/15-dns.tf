data "google_dns_managed_zone" "public_host_cloudtuple" {
  project    = "${data.terraform_remote_state.host.host_project_id}"
  name        = "public-host-cloudtuple"
}

data "google_dns_managed_zone" "private_apple_cloudtuple" {
  project = "${data.terraform_remote_state.host.host_project_id}"
  name    = "private-apple-cloudtuple"
}

data "google_dns_managed_zone" "private_googleapis" {
  project = "${data.terraform_remote_state.host.host_project_id}"
  name    = "private-googleapis"
}

resource "google_dns_record_set" "googleapis" {
  project      = "${data.terraform_remote_state.host.host_project_id}"
  managed_zone = "${data.google_dns_managed_zone.private_googleapis.name}"
  name         = "*.${data.google_dns_managed_zone.private_googleapis.dns_name}"
  type         = "CNAME"
  ttl          = 300
  rrdatas      = ["restricted.${data.google_dns_managed_zone.private_googleapis.dns_name}"]
}

resource "google_dns_record_set" "restricted_googleapis" {
  project      = "${data.terraform_remote_state.host.host_project_id}"
  managed_zone = "${data.google_dns_managed_zone.private_googleapis.name}"
  name         = "restricted.${data.google_dns_managed_zone.private_googleapis.dns_name}"
  type         = "A"
  ttl          = 300
  rrdatas      = [
    "199.36.153.7",
    "199.36.153.6",
    "199.36.153.4",
    "199.36.153.5"
  ]
}
