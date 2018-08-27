# Firewall Rules
#===========================
# allow ssh to instances
resource "google_compute_firewall" "allow_ssh" {
  name    = "${var.name}allow-ssh"
  network = "${google_compute_network.vpc.self_link}"

  allow {
    protocol = "tcp"
    ports = ["22"]
  }

  source_ranges = ["${data.external.onprem_ip.result.ip}"]
  target_tags = ["mig"]
}

# allow gfe (130.211.0.0/22 and 35.191.0.0/16)
# health check probes to blue mig instances
resource "google_compute_firewall" "allow_health_checks" {
  name    = "${var.name}allow-health-checks"
  network = "${google_compute_network.vpc.self_link}"

  allow {
    protocol = "tcp"
    ports = ["80"]
  }

  target_tags = ["mig"]

  source_ranges = ["130.211.0.0/22","35.191.0.0/16"]
}

# test rule to allow http access to instances from 0.0.0.0/0
# removed after test is complete
resource "google_compute_firewall" "allow_http_test" {
  name    = "${var.name}allow-http-test"
  network = "${google_compute_network.vpc.self_link}"

  allow {
    protocol = "tcp"
    ports = ["80"]
  }

  target_tags = ["mig"]
}

# Cloud Armor
#===========================
# default allow 0.0.0.0/0 and deny 9.9.9.0/24
resource "google_compute_security_policy" "prod_policy" {
  name = "${var.name}prod-policy"

  rule {
    action   = "deny(403)"
    priority = "1000"
    match {
      versioned_expr = "SRC_IPS_V1"
      config {
        src_ip_ranges = ["9.9.9.0/24"]
      }
    }
    description = "Deny access to IPs in 9.9.9.0/24"
  }

  rule {
    action   = "allow"
    priority = "2147483647"
    match {
      versioned_expr = "SRC_IPS_V1"
      config {
        src_ip_ranges = ["*"]
      }
    }
    description = "default rule"
  }
}

# default deny 0.0.0.0/0 and allow on-prem ip only
resource "google_compute_security_policy" "dev_policy" {
  name = "${var.name}dev-policy"

  rule {
    action   = "allow"
    priority = "1000"
    match {
      versioned_expr = "SRC_IPS_V1"
      config {
        src_ip_ranges = [
          "${data.external.onprem_ip.result.ip}"
        ]
      }
    }
    description = "Deny access to IPs in 9.9.9.0/24"
  }

  rule {
    action   = "deny(403)"
    priority = "2147483647"
    match {
      versioned_expr = "SRC_IPS_V1"
      config {
        src_ip_ranges = ["*"]
      }
    }
    description = "default rule"
  }
}
