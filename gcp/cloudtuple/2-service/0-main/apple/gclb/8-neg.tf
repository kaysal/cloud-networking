
# app1 = port 80
#------------------------------

# eu-w3-a

resource "google_compute_network_endpoint_group" "app1_eu_w3a" {
  provider     = google-beta
  name         = "${var.main}app1-eu-w3a"
  network      = data.google_compute_network.vpc.self_link
  subnetwork   = data.terraform_remote_state.vpc.outputs.apple_eu_w3_10_200_10
  default_port = "80"
  zone         = "europe-west3-a"
}

resource "google_compute_network_endpoint" "app1_eu_w3a_neg_vm1" {
  network_endpoint_group = google_compute_network_endpoint_group.app1_eu_w3a.name
  instance               = google_compute_instance.neg_eu_w3_vm1.name
  port                   = google_compute_network_endpoint_group.app1_eu_w3a.default_port
  ip_address             = google_compute_instance.neg_eu_w3_vm1.network_interface.0.network_ip
  zone                   = "europe-west3-a"
}

resource "google_compute_network_endpoint" "app1_eu_w3a_neg_vm2" {
  network_endpoint_group = google_compute_network_endpoint_group.app1_eu_w3a.name
  instance               = google_compute_instance.neg_eu_w3_vm2.name
  port                   = google_compute_network_endpoint_group.app1_eu_w3a.default_port
  ip_address             = "10.0.82.22"
  zone                   = "europe-west3-a"
}

# eu-w3-b

resource "google_compute_network_endpoint_group" "app1_eu_w3b" {
  provider     = google-beta
  name         = "${var.main}app1-eu-w3b"
  network      = data.google_compute_network.vpc.self_link
  subnetwork   = data.terraform_remote_state.vpc.outputs.apple_eu_w3_10_200_10
  default_port = "80"
  zone         = "europe-west3-b"
}

resource "google_compute_network_endpoint" "app1_eu_w3b_neg_vm3" {
  network_endpoint_group = google_compute_network_endpoint_group.app1_eu_w3b.name
  instance               = google_compute_instance.neg_eu_w3_vm3.name
  port                   = google_compute_network_endpoint_group.app1_eu_w3b.default_port
  ip_address             = "10.0.83.33"
  zone                   = "europe-west3-b"
}


# app2 = port 8080
#------------------------------

# eu-w3-a

resource "google_compute_network_endpoint_group" "app2_eu_w3a" {
  provider     = google-beta
  name         = "${var.main}app2-eu-w3a"
  network      = data.google_compute_network.vpc.self_link
  subnetwork   = data.terraform_remote_state.vpc.outputs.apple_eu_w3_10_200_10
  default_port = "8080"
  zone         = "europe-west3-a"
}

resource "google_compute_network_endpoint" "app2_eu_w3a_neg_vm1" {
  network_endpoint_group = google_compute_network_endpoint_group.app2_eu_w3a.name
  instance               = google_compute_instance.neg_eu_w3_vm1.name
  port                   = google_compute_network_endpoint_group.app2_eu_w3a.default_port
  ip_address             = google_compute_instance.neg_eu_w3_vm1.network_interface.0.network_ip
  zone                   = "europe-west3-a"
}
