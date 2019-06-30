resource "google_compute_network_endpoint_group" "app1_eu_w3a" {
  provider     = google-beta
  name         = "${var.main}app1-eu-w3a"
  network      = data.google_compute_network.vpc.self_link
  subnetwork   = data.terraform_remote_state.vpc.outputs.apple_eu_w3_10_200_10
  default_port = "80"
  zone         = "europe-west3-a"
}

resource "google_compute_network_endpoint_group" "app1_eu_w3b" {
  provider     = google-beta
  name         = "${var.main}app1-eu-w3b"
  network      = data.google_compute_network.vpc.self_link
  subnetwork   = data.terraform_remote_state.vpc.outputs.apple_eu_w3_10_200_10
  default_port = "80"
  zone         = "europe-west3-b"
}

resource "google_compute_network_endpoint_group" "app2_eu_w3a" {
  provider     = google-beta
  name         = "${var.main}app2-eu-w3a"
  network      = data.google_compute_network.vpc.self_link
  subnetwork   = data.terraform_remote_state.vpc.outputs.apple_eu_w3_10_200_10
  default_port = "8080"
  zone         = "europe-west3-a"
}

