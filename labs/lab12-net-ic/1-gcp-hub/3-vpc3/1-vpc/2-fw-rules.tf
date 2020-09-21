# base rules
#-----------------------------------

# ssh

resource "google_compute_firewall" "vpc3_allow_ssh" {
  name      = "vpc3-allow-ssh"
  network   = google_compute_network.vpc3.self_link
  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  priority      = "1000"

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }
}

# Use Case 1
#-----------------------------------

# allow rule is shadowed by deny rule,
# causing unexpected service disruption

resource "google_compute_firewall" "uc1_app2_allow_app1" {
  name      = "uc1-app2-allow-app1"
  network   = google_compute_network.vpc3.self_link
  direction = "INGRESS"

  allow {
    protocol = "all"
  }

  source_ranges = ["10.1.0.0/24"]
  target_tags   = ["web-app2"]
  priority      = "1000"

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_firewall" "uc1_app2_deny_all" {
  name      = "uc1-app2-deny-all"
  network   = google_compute_network.vpc3.self_link
  direction = "INGRESS"

  deny {
    protocol = "all"
  }

  source_ranges = ["10.1.0.0/16"]
  target_tags   = ["web-app2"]
  priority      = "1000"

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }
}

# Shadow rule variation
# 2 rules combined shadow a lower priority rule

resource "google_compute_firewall" "uc1_db4_allow_app3" {
  name      = "uc1-db4-allow-app3"
  network   = google_compute_network.vpc3.self_link
  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = ["10.3.0.0/24"]
  target_tags   = ["db-srv4"]
  priority      = "1000"

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_firewall" "uc1_db4_deny_http" {
  name      = "uc1-db4-deny-http"
  network   = google_compute_network.vpc3.self_link
  direction = "INGRESS"

  deny {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["10.3.0.0/24"]
  target_tags   = ["db-srv4"]
  priority      = "900"

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_firewall" "uc1_db4_deny_https" {
  name      = "uc1-db4-deny-https"
  network   = google_compute_network.vpc3.self_link
  direction = "INGRESS"

  deny {
    protocol = "tcp"
    ports    = ["443"]
  }

  source_ranges = ["10.3.0.0/24"]
  target_tags   = ["db-srv4"]
  priority      = "900"

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }
}


# Use Case 2
#-----------------------------------

# Allow Rule with no Hit

resource "google_compute_firewall" "uc2_test_allow_rdp" {
  name      = "uc2-test-allow-rdp"
  network   = google_compute_network.vpc3.self_link
  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports    = ["3389"]
  }

  source_ranges = ["10.1.0.0/24", ]
  target_tags   = ["auth-srv6", ]
  priority      = "1000"

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }
}

# Similar rules (2 with Hit)

resource "google_compute_firewall" "uc2_test_allow_rdp2" {
  name      = "uc2-test-allow-rdp2"
  network   = google_compute_network.vpc3.self_link
  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports    = ["3389"]
  }

  source_ranges = ["10.2.0.0/24", ]
  target_tags   = ["auth-srv6", ]
  priority      = "1000"

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_firewall" "uc2_test_allow_rdp3" {
  name      = "uc2-test-allow-rdp3"
  network   = google_compute_network.vpc3.self_link
  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports    = ["3389"]
  }

  source_ranges = ["10.3.0.0/24", ]
  target_tags   = ["auth-srv6", ]
  priority      = "1000"

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_firewall" "uc2_test_allow_rdp4" {
  name      = "uc2-test-allow-rdp4"
  network   = google_compute_network.vpc3.self_link
  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports    = ["3389"]
  }

  source_ranges = ["10.4.0.0/24", ]
  target_tags   = ["auth-srv6", ]
  priority      = "1000"

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_firewall" "uc2_test_allow_rdp5" {
  name      = "uc2-test-allow-rdp5"
  network   = google_compute_network.vpc3.self_link
  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports    = ["3389"]
  }

  source_ranges = ["10.5.0.0/24", ]
  target_tags   = ["auth-srv6", ]
  priority      = "1000"

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_firewall" "uc2_app1_allow_internet" {
  name      = "uc2-app1-allow-internet"
  network   = google_compute_network.vpc3.self_link
  direction = "INGRESS"

  allow {
    protocol = "tcp"
  }

  source_ranges = ["0.0.0.0/0", ]
  target_tags   = ["web-app1", ]
  priority      = "1000"

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_firewall" "uc2_app1_deny_icmp" {
  name      = "uc2-app1-deny-icmp"
  network   = google_compute_network.vpc3.self_link
  direction = "INGRESS"

  deny {
    protocol = "icmp"
  }

  source_ranges = ["10.100.0.0/24", ]
  target_tags   = ["web-app1", ]
  priority      = "1000"

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_firewall" "uc2_app1_allow_ssh" {
  name      = "uc2-app1-allow-ssh"
  network   = google_compute_network.vpc3.self_link
  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["10.55.0.0/24", ]
  target_tags   = ["web-app1", ]
  priority      = "1000"

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }
}

# Use Case 3
#-----------------------------------

# mysql partial hit

resource "google_compute_firewall" "uc3_db7_allow_mysql" {
  name      = "uc3-db7-allow-mysql"
  network   = google_compute_network.vpc3.self_link
  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports = [
      "3306", "6446", "389"
    ]
  }

  source_ranges = ["10.7.0.0/24", ]
  target_tags   = ["db8-mysql", ]
  priority      = "1000"

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_firewall" "uc3_anthos_allow_admin" {
  name      = "uc3-anthos-allow-admin"
  network   = google_compute_network.vpc3.self_link
  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports    = ["22", "443", "30000-32767"]
  }

  source_ranges = ["10.7.0.0/24", ]
  target_tags   = ["anthos8-fw", ]
  priority      = "1000"

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }
}

# Use Case 4
#-----------------------------------

resource "google_compute_firewall" "uc4_web_deny_web" {
  name      = "uc4-web-deny-web"
  network   = google_compute_network.vpc3.self_link
  direction = "INGRESS"

  deny {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = ["0.0.0.0/0", ]
  target_tags   = ["web-app10", ]
  priority      = "1000"

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }
}
