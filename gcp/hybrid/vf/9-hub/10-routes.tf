
# untrust

resource "google_compute_route" "untrust_to_trust1_b" {
  project           = var.project_id_hub
  name              = "${local.prefix_untrust}to-trust1-b"
  description       = "Route to trust1"
  dest_range        = var.hub.trust1.cidr.spoke1
  network           = google_compute_network.untrust.self_link
  next_hop_instance = google_compute_instance.eu1_nva1.self_link
  priority          = 1000
}

resource "google_compute_route" "untrust_to_trust1_c" {
  project           = var.project_id_hub
  name              = "${local.prefix_untrust}to-trust1-c"
  description       = "Route to trust1"
  dest_range        = var.hub.trust1.cidr.spoke1
  network           = google_compute_network.untrust.self_link
  next_hop_instance = google_compute_instance.eu1_nvvf.self_link
  priority          = 1000
}

resource "google_compute_route" "untrust_to_trust2_b" {
  project           = var.project_id_hub
  name              = "${local.prefix_untrust}to-trust2-b"
  description       = "Route to trust2"
  dest_range        = var.hub.trust2.cidr.spoke2
  network           = google_compute_network.untrust.self_link
  next_hop_instance = google_compute_instance.eu2_nva1.self_link
  priority          = 1000
}

resource "google_compute_route" "untrust_to_trust2_c" {
  project           = var.project_id_hub
  name              = "${local.prefix_untrust}to-trust2-c"
  description       = "Route to trust2"
  dest_range        = var.hub.trust2.cidr.spoke2
  network           = google_compute_network.untrust.self_link
  next_hop_instance = google_compute_instance.eu2_nvvf.self_link
  priority          = 1000
}

# trust1

resource "google_compute_route" "trust1_private_googleapis" {
  project          = var.project_id_hub
  name             = "${local.prefix_trust1}private-googleapis"
  description      = "Route to default gateway for private.googleapis.com"
  dest_range       = "199.36.153.4/30"
  network          = google_compute_network.trust1.self_link
  next_hop_gateway = "default-internet-gateway"
  priority         = 1000
}

resource "google_compute_route" "trust1_restricted_googleapis" {
  project          = var.project_id_hub
  name             = "${local.prefix_trust1}restricted-googleapis"
  description      = "Route to default gateway for restricted.googleapis.com"
  dest_range       = "199.36.153.8/30"
  network          = google_compute_network.trust1.self_link
  next_hop_gateway = "default-internet-gateway"
  priority         = 1000
}

resource "google_compute_route" "trust1_to_onprem_b" {
  project           = var.project_id_hub
  name              = "${local.prefix_trust1}to-onprem-b"
  description       = "Route to onprem subnets"
  dest_range        = "172.16.0.0/16"
  network           = google_compute_network.trust1.self_link
  next_hop_instance = google_compute_instance.eu1_nva1.self_link
  priority          = 1000
}

resource "google_compute_route" "trust1_to_onprem_c" {
  project           = var.project_id_hub
  name              = "${local.prefix_trust1}to-onprem-c"
  description       = "Route to onprem subnets"
  dest_range        = "172.16.0.0/16"
  network           = google_compute_network.trust1.self_link
  next_hop_instance = google_compute_instance.eu1_nvvf.self_link
  priority          = 1000
}

# trust2

resource "google_compute_route" "trust2_private_googleapis" {
  project          = var.project_id_hub
  name             = "${local.prefix_trust2}private-googleapis"
  description      = "Route to default gateway for private.googleapis.com"
  dest_range       = "199.36.153.4/30"
  network          = google_compute_network.trust2.self_link
  next_hop_gateway = "default-internet-gateway"
  priority         = 1000
}

resource "google_compute_route" "trust2_restricted_googleapis" {
  project          = var.project_id_hub
  name             = "${local.prefix_trust2}restricted-googleapis"
  description      = "Route to default gateway for restricted.googleapis.com"
  dest_range       = "199.36.153.8/30"
  network          = google_compute_network.trust2.self_link
  next_hop_gateway = "default-internet-gateway"
  priority         = 1000
}

resource "google_compute_route" "trust2_to_onprem_b" {
  project           = var.project_id_hub
  name              = "${local.prefix_trust2}to-onprem-b"
  description       = "Route to onprem subnets"
  dest_range        = "172.16.0.0/16"
  network           = google_compute_network.trust2.self_link
  next_hop_instance = google_compute_instance.eu2_nva1.self_link
  priority          = 1000
}

resource "google_compute_route" "trust2_to_onprem_c" {
  project           = var.project_id_hub
  name              = "${local.prefix_trust2}to-onprem-c"
  description       = "Route to onprem subnets"
  dest_range        = "172.16.0.0/16"
  network           = google_compute_network.trust2.self_link
  next_hop_instance = google_compute_instance.eu2_nvvf.self_link
  priority          = 1000
}
