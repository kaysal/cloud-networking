# LB address targetting PAN instance group
#--------------------------------------
resource "google_compute_global_address" "ext_ip" {
  name = "${var.name}ext-ip"
}

resource "google_dns_record_set" "pan_gclb" {
  project      = data.terraform_remote_state.host.outputs.host_project_id
  managed_zone = data.google_dns_managed_zone.public_host_cloudtuple.name
  name         = "pan.${data.google_dns_managed_zone.public_host_cloudtuple.dns_name}"
  type         = "A"
  ttl          = 300
  rrdatas      = [google_compute_global_address.ext_ip.address]
}

