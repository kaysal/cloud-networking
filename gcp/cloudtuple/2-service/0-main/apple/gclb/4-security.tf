# Cloud Armor
#===========================

# default allow 0.0.0.0/0 and deny 9.9.9.0/24
#-----------------------------------
resource "google_compute_security_policy" "prod_app_policy" {
  name = "${var.main}prod-app-policy"

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
#-----------------------------------
resource "google_compute_security_policy" "dev_app_policy" {
  name = "${var.main}dev-app-policy"

  rule {
    action   = "allow"
    priority = "1000"

    match {
      versioned_expr = "SRC_IPS_V1"

      config {
        src_ip_ranges = ["0.0.0.0/0", data.external.onprem_ip.result.ip]
      }
    }

    description = "allow only onprem ip"
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

