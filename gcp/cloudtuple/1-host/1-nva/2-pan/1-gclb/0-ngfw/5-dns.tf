resource "google_dns_record_set" "mgt_pan_b" {
  project      = "${data.terraform_remote_state.host.host_project_id}"
  managed_zone = "${data.google_dns_managed_zone.public_host_cloudtuple.name}"
  name         = "panb.gclb.${data.google_dns_managed_zone.public_host_cloudtuple.dns_name}"
  type         = "A"
  ttl          = 300
  rrdatas      = ["${google_compute_instance.fw_b.network_interface.1.access_config.0.nat_ip}"]
}

resource "google_dns_record_set" "mgt_pan_c" {
  project      = "${data.terraform_remote_state.host.host_project_id}"
  managed_zone = "${data.google_dns_managed_zone.public_host_cloudtuple.name}"
  name         = "panc.gclb.${data.google_dns_managed_zone.public_host_cloudtuple.dns_name}"
  type         = "A"
  ttl          = 300
  rrdatas      = ["${google_compute_instance.fw_c.network_interface.1.access_config.0.nat_ip}"]
}
