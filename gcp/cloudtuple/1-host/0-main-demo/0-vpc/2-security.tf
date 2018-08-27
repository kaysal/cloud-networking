# allow gfe to HTTPS LB GCE nodes
resource "google_compute_firewall" "hc_gfe_to_gce" {
  name    = "${var.name}hc-gfe-to-gce"
  description = "allow gfe to MIG"
  network = "${google_compute_network.vpc.self_link}"

  allow {
    protocol = "tcp"
    ports = ["80"]
  }

  source_ranges = ["130.211.0.0/22","35.191.0.0/16"]
  target_tags = ["mig"]
}

# allow gfe to GKE ILB and LoadBalancer (NLB) on tcp:10256
resource "google_compute_firewall" "hc_gfe_to_gke_ilb_nlb" {
  name    = "${var.name}hc-gfe-to-gke-ilb-nlb"
  description = "allow gfe to GKE nodes on tcp 10256 for ILB and NLB"
  network = "${google_compute_network.vpc.self_link}"

  allow {
    protocol = "tcp"
    ports = ["10256"]
  }

  source_ranges = ["130.211.0.0/22","35.191.0.0/16"]
  target_tags = ["gke-node"]
}

# allow gfe to GKE Ingress on NodePort range
resource "google_compute_firewall" "hc_gfe_to_gke_ingress" {
  name    = "${var.name}hc-gfe-to-gke-ingress"
  description = "allow gfe to GKE ingress nodes on NodePort range"
  network = "${google_compute_network.vpc.self_link}"

  allow {
    protocol = "tcp"
    ports = ["30000-32767"]
  }

  source_ranges = ["130.211.0.0/22","35.191.0.0/16"]
  target_tags = ["gke-node"]
}

# allow internet to GKE NLB nodes
resource "google_compute_firewall" "web_to_gke_nlb" {
  name    = "${var.name}web-to-gke-nlb"
  description = "allow external web to GKE nodes using NLB"
  network = "${google_compute_network.vpc.self_link}"

  allow {
    protocol = "tcp"
    ports = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags = ["gke-node"]
}

# onprem access
resource "google_compute_firewall" "onprem_to_bastion" {
  name    = "${var.name}onprem-to-bastion"
  description = "access to bastion"
  network = "${google_compute_network.vpc.self_link}"

  allow {
    protocol = "tcp"
    ports = ["22"]
  }

  allow {
    protocol = "tcp"
    ports = ["3389"]
  }

  source_ranges = ["${data.external.onprem_ip.result.ip}"]
  target_tags = ["bastion"]
}

# allow bastion to access vpc
resource "google_compute_firewall" "bastion_to_vpc" {
  name    = "${var.name}bastion-to-vpc"
  description = "allowed connections from bastion to vpc"
  network = "${google_compute_network.vpc.self_link}"

  allow {
    protocol = "all"
  }

  source_tags = ["bastion"]
}

# vm vpc access
resource "google_compute_firewall" "vm_to_vpc" {
  name    = "${var.name}vm-to-vpc"
  description = "allowed connections from vm to vpc"
  network = "${google_compute_network.vpc.self_link}"

  allow {
    protocol = "all"
  }

  source_tags = ["vm"]
  target_tags = ["vm"]
}

resource "google_compute_firewall" "vm_to_gke" {
  name    = "${var.name}vm-to-gke"
  description = "allowed connections from vm to gke"
  network = "${google_compute_network.vpc.self_link}"

  allow {
    protocol = "tcp"
    ports = ["8080","30000-32767"]
  }

  source_tags = ["vm"]
  target_tags = ["gke-node"]
}


# aws access to GCE
resource "google_compute_firewall" "aws_to_gce" {
  name    = "${var.name}aws-to-gce"
  description = "allowed connections from aws to gce"
  network = "${google_compute_network.vpc.self_link}"

  allow {
    protocol = "tcp"
    ports = ["80","8080","443","53"]
  }

  allow {
    protocol = "udp"
    ports = ["33434-33534","53"]
  }

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports = ["3389"]
  }

  source_ranges = [
    "172.16.10.0/24",
    "172.18.10.0/24"
  ]

  target_tags = ["vm"]

}

# aws access to GKE
resource "google_compute_firewall" "aws_to_gke" {
  name    = "${var.name}aws-to-gke"
  description = "allowed connections from aws to gce"
  network = "${google_compute_network.vpc.self_link}"

  allow {
    protocol = "tcp"
    ports = ["80","8080","53","30000-32767"]
  }

  allow {
    protocol = "udp"
    ports = ["33434-33534","53"]
  }

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports = ["3389"]
  }

  source_ranges = [
    "172.16.10.0/24",
    "172.18.10.0/24"
  ]

  target_tags = ["gke-node"]

}
