# gfe proxy
#----------------------
# gce: tcp_proxy = tcp/(allowed ports)
# gce: http_proxy = tcp/80;8080
# gce: ilb = tcp, udp
# gke: ilb = tcp/10256
# gke: ingress = tcp/30000-32767

resource "google_compute_firewall" "gfe_http_ssl_tcp_internal" {
  provider    = "google-beta"
  name        = "${var.env}gfe-http-ssl-tcp-internal"
  description = "gfe http ssl tcp internal"
  network     = "${google_compute_network.vpc.self_link}"

  #enable_logging = true

  allow {
    protocol = "tcp"
    ports    = [80, 8080, 110, 10256, "30000-32767"]
  }
  allow {
    protocol = "udp"
  }
  source_ranges = ["${data.google_compute_lb_ip_ranges.ranges.http_ssl_tcp_internal}"]
  target_tags   = ["mig"]
}

# gfe nlb
#----------------------
# gce: nlb = tcp
# gke: nlb = tcp/10256

resource "google_compute_firewall" "gfe_nlb" {
  provider    = "google-beta"
  name        = "${var.env}gfe-nlb"
  description = "gfe nlb"
  network     = "${google_compute_network.vpc.self_link}"

  #enable_logging = true

  allow {
    protocol = "tcp"
  }
  allow {
    protocol = "udp"
  }
  source_ranges = ["${data.google_compute_lb_ip_ranges.ranges.network}"]
  target_tags   = ["mig-nlb"]
}

# web nlb
#----------------------
resource "google_compute_firewall" "web_nlb" {
  provider    = "google-beta"
  name        = "${var.env}web-nlb"
  description = "web to nlb mig"
  network     = "${google_compute_network.vpc.self_link}"

  #enable_logging = true

  allow {
    protocol = "tcp"
  }
  allow {
    protocol = "udp"
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["mig-nlb"]
}

# gce to gce
#----------------------
resource "google_compute_firewall" "gce_gce" {
  provider    = "google-beta"
  name        = "${var.env}gce-gce"
  description = "allow all gce to gce"
  network     = "${google_compute_network.vpc.self_link}"

  #enable_logging = true

  allow {
    protocol = "all"
  }
  source_tags = ["gce"]
  target_tags = ["gce"]
}

# gke to gke
#----------------------
# ports = tcp, udp, icmp, ah, sctp

resource "google_compute_firewall" "gke_gke" {
  provider    = "google-beta"
  name        = "${var.env}gke-gke"
  description = "allow all gke to gke"
  network     = "${google_compute_network.vpc.self_link}"

  #enable_logging = true

  allow {
    protocol = "all"
  }
  source_tags = ["gke"]
  target_tags = ["gke"]
}

# gce to gke
#----------------------
resource "google_compute_firewall" "gce_gke" {
  provider    = "google-beta"
  name        = "${var.env}gce-gke"
  description = "allow gce to gke"
  network     = "${google_compute_network.vpc.self_link}"

  #enable_logging = true

  allow {
    protocol = "all"
  }
  source_tags = ["gce"]
  target_tags = ["gke"]
}

# gke to gce
#----------------------
resource "google_compute_firewall" "gke_gce" {
  provider    = "google-beta"
  name        = "${var.env}gke-gce"
  description = "allow gke to gce"
  network     = "${google_compute_network.vpc.self_link}"

  #enable_logging = true

  allow {
    protocol = "all"
  }
  source_tags = ["gke"]
  target_tags = ["gce"]
}

# external ssh and rdp
#----------------------
resource "google_compute_firewall" "external_ssh_rdp" {
  provider    = "google-beta"
  name        = "${var.env}external-ssh-rdp"
  description = "external ssh rdp"
  network     = "${google_compute_network.vpc.self_link}"

  #enable_logging = true

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  allow {
    protocol = "tcp"
    ports    = ["3389"]
  }
  source_ranges = ["0.0.0.0/0", "${data.external.onprem_ip.result.ip}"]
  target_tags   = ["gce", "gke"]
}

# external to gce elk
#----------------------
# gce: elk port = tcp/5601
resource "google_compute_firewall" "external_elk" {
  provider    = "google-beta"
  name        = "${var.env}external-elk"
  description = "external to elk"
  network     = "${google_compute_network.vpc.self_link}"

  #enable_logging = true

  allow {
    protocol = "tcp"
    ports    = ["5601"]
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["elk"]
}

# bastion
#----------------------
resource "google_compute_firewall" "bastion" {
  provider    = "google-beta"
  name        = "${var.env}bastion"
  description = "allow connections from bastion"
  network     = "${google_compute_network.vpc.self_link}"

  #enable_logging = true

  allow {
    protocol = "all"
  }
  source_tags = ["bastion"]
}

# rfc1918 to gce
#----------------------
# gke pod ip range to gce (node tags only affects gke node ip range)
# all other external private ip sources
resource "google_compute_firewall" "rfc1918_gce" {
  provider    = "google-beta"
  name        = "${var.env}pod-gce"
  description = "rfc1918 to gce"
  network     = "${google_compute_network.vpc.self_link}"

  #enable_logging = true

  allow {
    protocol = "all"
  }
  source_ranges = [
    "10.0.0.0/8",
    "172.16.0.0/12",
    "192.168.0.0/16",
  ]
  target_tags = ["gce"]
}

# cgn ip range to gce
#----------------------
# gke pod ip range to gce (node tags only affects gke node ip range)
# all other external private ip sources
resource "google_compute_firewall" "cgn_gce" {
  provider    = "google-beta"
  name        = "${var.env}cgn-gce"
  description = "cgn ip address pace to gce"
  network     = "${google_compute_network.vpc.self_link}"

  #enable_logging = true

  allow {
    protocol = "all"
  }
  source_ranges = ["100.64.0.0/10"]
  target_tags   = ["gce"]
}

# rfc1918 to gke
#----------------------
# gke pod ip range to gke (node tags only affects gke node ip range)
# all other external private ip sources
resource "google_compute_firewall" "rfc1918_gke" {
  provider    = "google-beta"
  name        = "${var.env}pod-gke"
  description = "rfc1918 to gke"
  network     = "${google_compute_network.vpc.self_link}"

  #enable_logging = true

  allow {
    protocol = "all"
  }
  source_ranges = [
    "10.0.0.0/8",
    "172.16.0.0/12",
    "192.168.0.0/16",
  ]
  target_tags = ["gke"]
}
