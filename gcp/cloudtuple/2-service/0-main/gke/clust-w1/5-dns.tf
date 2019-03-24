data "google_dns_managed_zone" "public_host_cloudtuple" {
  project = "${data.terraform_remote_state.host.host_project_id}"
  name    = "public-host-cloudtuple"
}

data "google_dns_managed_zone" "private_gke_cloudtuple" {
  project = "${data.terraform_remote_state.host.host_project_id}"
  name    = "private-gke-cloudtuple"
}

resource "google_dns_record_set" "gke_php_ingress" {
  project      = "${data.terraform_remote_state.host.host_project_id}"
  managed_zone = "${data.google_dns_managed_zone.public_host_cloudtuple.name}"
  name         = "ingress.php.${data.google_dns_managed_zone.public_host_cloudtuple.dns_name}"
  type         = "A"
  ttl          = 300
  rrdatas      = ["${google_compute_global_address.gke_php_ingress_ip.address}"]
}
