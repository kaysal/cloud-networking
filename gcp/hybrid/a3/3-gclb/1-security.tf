# cloud armor rules
#-----------------------------------

resource "google_compute_security_policy" "allowed_clients" {
  name = "${var.global.prefix}allowed-clients"

  rule {
    action   = "allow"
    priority = "1000"

    match {
      versioned_expr = "SRC_IPS_V1"

      config {
        src_ip_ranges = [local.ip.ovpn_ext_ip.address]
      }
    }

    description = "allowed clients"
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
