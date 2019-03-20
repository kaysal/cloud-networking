# GFE to GCE
# ======================
# allow gfe to LBs - gclb
resource "google_compute_firewall" "gfe_gce_gclb" {
  provider       = "google-beta"
  name           = "${var.name}gfe-gce-gclb"
  description    = "allow gfe to gclb MIG"
  network        = "${google_compute_network.vpc.self_link}"
  enable_logging = true

  allow {
    protocol = "tcp"
    ports    = ["80", "8080"]
  }

  source_ranges = ["${data.google_compute_lb_ip_ranges.ranges.http_ssl_tcp_internal}"]
  target_tags   = ["gce-mig-gclb"]
}

# allow gfe to gce tcp proxy LB on port 110
resource "google_compute_firewall" "gfe_gce_tcp" {
  name        = "${var.name}gfe-gce-tcp"
  description = "allow gfe to gce tcp proxy lb"
  network     = "${google_compute_network.vpc.self_link}"

  #enable_logging = true

  allow {
    protocol = "tcp"
    ports    = ["80", "110"]
  }
  source_ranges = ["${data.google_compute_lb_ip_ranges.ranges.http_ssl_tcp_internal}"]
  target_tags   = ["gce-mig-tcp"]
}

# allow traffic to gce external ilb instances
resource "google_compute_firewall" "gfe_gce_ilb" {
  name        = "${var.name}gfe-gce-ilb"
  description = "allow gfe to ilb"
  network     = "${google_compute_network.vpc.self_link}"

  #enable_logging = true

  allow {
    protocol = "tcp"
    ports    = ["80", "8080"]
  }
  source_ranges = ["${data.google_compute_lb_ip_ranges.ranges.http_ssl_tcp_internal}"]
  target_tags   = ["gce-mig-ilb"]
}

# Web to GCE NLB (including GFE to GCE NLB)
# ======================
# allow traffic to gce external nlb instances
resource "google_compute_firewall" "web_gce_nlb" {
  name        = "${var.name}web-gce-nlb"
  description = "allow all traffic to nlb"
  network     = "${google_compute_network.vpc.self_link}"

  #enable_logging = true

  allow {
    protocol = "tcp"
    ports    = ["80", "8080"]
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["gce-mig-nlb"]
}

# GFE to GKE
# ======================
# allow gfe to gke ilb on tcp:10256
resource "google_compute_firewall" "gfe_gke_ilb" {
  name        = "${var.name}gfe-gke-ilb"
  description = "allow gfe to GKE ILB nodes on tcp 10256"
  network     = "${google_compute_network.vpc.self_link}"

  #enable_logging = true

  allow {
    protocol = "tcp"
    ports    = ["10256"]
  }
  source_ranges = ["${data.google_compute_lb_ip_ranges.ranges.http_ssl_tcp_internal}"]
  target_tags   = ["gke"]
}

# allow gfe to gke nlb on tcp:10256
resource "google_compute_firewall" "gfe_gke_nlb" {
  name        = "${var.name}gfe-gke-nlb"
  description = "allow gfe to GKE NLB nodes on tcp 10256"
  network     = "${google_compute_network.vpc.self_link}"

  #enable_logging = true

  allow {
    protocol = "tcp"
    ports    = ["10256"]
  }
  source_ranges = ["${data.google_compute_lb_ip_ranges.ranges.network}"]
  target_tags   = ["gke"]
}

# allow gfe to gke ingress on NodePort range
resource "google_compute_firewall" "gfe_gke_ing" {
  provider       = "google-beta"
  name           = "${var.name}gfe-gke-ing"
  description    = "allow gfe to GKE ingress nodes on NodePort range"
  network        = "${google_compute_network.vpc.self_link}"
  enable_logging = true

  allow {
    protocol = "tcp"
    ports    = ["30000-32767"]
  }

  source_ranges = ["${data.google_compute_lb_ip_ranges.ranges.http_ssl_tcp_internal}"]
  target_tags   = ["gke"]
}

# Web to GKE NLB
# ===============================
resource "google_compute_firewall" "web_gke_nlb" {
  provider       = "google-beta"
  name           = "${var.name}web-gke-nlb"
  description    = "allow external web to GKE nodes using NLB"
  network        = "${google_compute_network.vpc.self_link}"
  enable_logging = true

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["gke"]
}

# Onprem access
# ======================
resource "google_compute_firewall" "onprem_bastion" {
  provider       = "google-beta"
  name           = "${var.name}onprem-bastion"
  description    = "access to bastion"
  network        = "${google_compute_network.vpc.self_link}"
  enable_logging = true

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  allow {
    protocol = "tcp"
    ports    = ["3389"]
  }

  source_ranges = ["0.0.0.0/0", "${data.external.onprem_ip.result.ip}"]
  target_tags   = ["bastion"]
}

resource "google_compute_firewall" "onprem_elk" {
  provider       = "google-beta"
  name           = "${var.name}onprem-elk"
  description    = "access to elk"
  network        = "${google_compute_network.vpc.self_link}"
  enable_logging = true

  allow {
    protocol = "tcp"
    ports    = ["22","5601"]
  }

  source_ranges = ["0.0.0.0/0", "${data.external.onprem_ip.result.ip}"]
  target_tags   = ["elk"]
}

# VPC access
# ===========================
# vm to vpc access
resource "google_compute_firewall" "gce_vpc" {
  provider       = "google-beta"
  name           = "${var.name}gce-vpc"
  description    = "allowed connections from vm to vpc"
  network        = "${google_compute_network.vpc.self_link}"
  enable_logging = true

  allow {
    protocol = "all"
  }

  source_tags = ["gce"]
  target_tags = ["gce"]
}

# gce to gke
resource "google_compute_firewall" "gce_gke" {
  provider       = "google-beta"
  name           = "${var.name}gce-gke"
  description    = "allow connections from gce to gke"
  network        = "${google_compute_network.vpc.self_link}"
  enable_logging = true

  allow {
    protocol = "tcp"
    ports    = ["80", "8080", "30000-32767"]
  }

  allow {
    protocol = "icmp"
  }

  source_tags = ["gce"]
  target_tags = ["gke"]
}

# bastion to vpc
resource "google_compute_firewall" "bastion_vpc" {
  provider       = "google-beta"
  name           = "${var.name}bastion-vpc"
  description    = "allow connections from gce to gke"
  network        = "${google_compute_network.vpc.self_link}"
  enable_logging = true

  allow {
    protocol = "all"
  }

  source_tags = ["bastion"]
}

# gke to gce
resource "google_compute_firewall" "gke_gce" {
  provider       = "google-beta"
  name           = "${var.name}gke-gce"
  description    = "allow connections from gce to gke"
  network        = "${google_compute_network.vpc.self_link}"
  enable_logging = true

  allow {
    protocol = "tcp"
  }

  allow {
    protocol = "icmp"
  }

  source_tags = ["gke"]
  target_tags = ["gce"]
}


# AWS to GCE
# ===========================
resource "google_compute_firewall" "aws_gce" {
  provider       = "google-beta"
  name           = "${var.name}aws-gce"
  description    = "allowed connections from aws to gce"
  network        = "${google_compute_network.vpc.self_link}"
  enable_logging = true

  allow {
    protocol = "tcp"
    ports    = ["80", "8080", "443", "53", "110"]
  }

  allow {
    protocol = "udp"
    ports    = ["33434-33534", "53"]
  }

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["3389"]
  }

  source_ranges = [
    "172.16.0.0/16",
    "172.17.0.0/16",
    "172.18.0.0/16",
  ]

  target_tags = ["gce"]
}

# AWS to GKE
# ===========================
resource "google_compute_firewall" "aws_gke" {
  provider       = "google-beta"
  name           = "${var.name}aws-gke"
  description    = "allowed connections from aws to gce"
  network        = "${google_compute_network.vpc.self_link}"
  enable_logging = true

  allow {
    protocol = "tcp"
    ports    = ["80", "8080", "53", "30000-32767"]
  }

  allow {
    protocol = "udp"
    ports    = ["33434-33534", "53"]
  }

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["3389"]
  }

  source_ranges = [
    "172.16.0.0/16",
    "172.17.0.0/16",
    "172.18.0.0/16",
  ]

  target_tags = ["gke"]
}

# Mango Project to gce
# ===========================
resource "google_compute_firewall" "mango_to_gce" {
  provider       = "google-beta"
  name           = "${var.name}mango-to-gce"
  network        = "${google_compute_network.vpc.self_link}"
  enable_logging = true

  allow {
    protocol = "all"
  }

  source_ranges = ["10.200.30.0/24"]
  target_tags   = ["gce"]
}

# Mango Project to gke
# ===========================
resource "google_compute_firewall" "mango_to_gke" {
  provider       = "google-beta"
  name           = "${var.name}mango-to-gke"
  network        = "${google_compute_network.vpc.self_link}"
  enable_logging = true

  allow {
    protocol = "all"
  }

  source_ranges = ["10.200.30.0/24"]
  target_tags   = ["gke"]
}
