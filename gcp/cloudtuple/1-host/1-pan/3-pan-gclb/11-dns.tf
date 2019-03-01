data "google_dns_managed_zone" "public_host_cloudtuple" {
  project = "${data.terraform_remote_state.host.host_project_id}"
  name    = "public-host-cloudtuple"
}

resource "google_dns_record_set" "mgt_pan" {
  project      = "${data.terraform_remote_state.host.host_project_id}"
  managed_zone = "${data.google_dns_managed_zone.public_host_cloudtuple.name}"
  name         = "mgt.pan${count.index + 1}.${data.google_dns_managed_zone.public_host_cloudtuple.dns_name}"
  type         = "A"
  ttl          = 300
  rrdatas      = ["${element(google_compute_instance.fw.*.network_interface.1.access_config.0.nat_ip, count.index)}"]
  count        = "${var.pan_count}"
}

resource "google_dns_record_set" "pan_gclb_vip" {
  managed_zone = "${data.google_dns_managed_zone.public_host_cloudtuple.name}"
  name         = "pan.${data.google_dns_managed_zone.public_host_cloudtuple.dns_name}"
  type         = "A"
  ttl          = 300
  rrdatas      = ["${google_compute_global_address.ext_ip.address}"]
}
