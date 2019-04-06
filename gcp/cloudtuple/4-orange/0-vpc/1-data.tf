# org data for orange project
data "terraform_remote_state" "orange" {
  backend = "gcs"

  config {
    bucket = "tf-shk"
    prefix = "states/gcp/cloudtuple/0-org/3-orange"
  }
}

# host project data
data "terraform_remote_state" "host" {
  backend = "gcs"

  config {
    bucket = "tf-shk"
    prefix = "states/gcp/cloudtuple/0-org/1-host"
  }
}

# dns data
data "google_dns_managed_zone" "public_host_cloudtuple" {
  project = "${data.terraform_remote_state.host.host_project_id}"
  name    = "public-host-cloudtuple"
}

# capture local machine ipv4
data "external" "onprem_ip" {
  program = ["sh", "scripts/onprem-ip.sh"]
}

# GFE LB IP ranges
data "google_compute_lb_ip_ranges" "ranges" {}

output "nlb" {
  value = "${data.google_compute_lb_ip_ranges.ranges.network}"
}

output "http_ssl_tcp_internal" {
  value = "${data.google_compute_lb_ip_ranges.ranges.http_ssl_tcp_internal}"
}
