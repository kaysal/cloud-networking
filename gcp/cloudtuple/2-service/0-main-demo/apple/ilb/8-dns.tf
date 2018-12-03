data "google_dns_managed_zone" "cloudtuple" {
  name = "cloudtuple"
}

# Bastion host
resource "google_dns_record_set" "bastion" {
  managed_zone = "${data.google_dns_managed_zone.cloudtuple.name}"
  name         = "ilb.bastion.${data.google_dns_managed_zone.cloudtuple.dns_name}"
  type         = "A"
  ttl          = 300
  rrdatas = ["${google_compute_instance.bastion_eu_w1.network_interface.0.access_config.0.nat_ip}"]
}
