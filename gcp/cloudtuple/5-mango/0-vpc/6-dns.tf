# private google api
#--------------------------------
resource "google_dns_managed_zone" "private_googleapis" {
  provider    = "google-beta"
  name        = "${var.main}private-googleapis"
  dns_name    = "googleapis.com."
  description = "private zone for googleapis"
  visibility  = "private"

  labels = {
    foo = "bar"
  }

  private_visibility_config {
    networks {
      network_url = "${google_compute_network.vpc.self_link}"
    }
  }
}

resource "google_dns_record_set" "googleapis_cname" {
  name = "*.${google_dns_managed_zone.private_googleapis.dns_name}"
  type = "CNAME"
  ttl  = 300

  managed_zone = "${google_dns_managed_zone.private_googleapis.name}"
  rrdatas = ["restricted.${google_dns_managed_zone.private_googleapis.dns_name}"]
}

resource "google_dns_record_set" "restricted_googleapis" {
  name = "restricted.${google_dns_managed_zone.private_googleapis.dns_name}"
  type = "A"
  ttl  = 300

  managed_zone = "${google_dns_managed_zone.private_googleapis.name}"

  rrdatas = [
    "199.36.153.4",
    "199.36.153.5",
    "199.36.153.6",
    "199.36.153.7"
  ]
}

# Main VPC Private Zone
#--------------------------------
resource "google_dns_managed_zone" "private_mango_cloudtuple" {
  provider    = "google-beta"
  name        = "${var.main}private-mango-cloudtuple"
  dns_name    = "mango.cloudtuple.com."
  description = "private zone for mango project"
  visibility  = "private"

  labels = {
    foo = "bar"
  }

  private_visibility_config {
    networks {
      network_url = "${google_compute_network.vpc.self_link}"
    }
  }
}

# AWS Zones
#--------------------------------
resource "google_dns_managed_zone" "private_aws_west1_cloudtuples" {
  provider    = "google-beta"
  name        = "${var.main}private-aws-west1-cloudtuples"
  dns_name    = "west1.cloudtuples.com."
  description = "zone queries to aws west1 region"
  visibility  = "private"

  labels = {
    foo = "bar"
  }

  private_visibility_config {
    networks {
      network_url = "${google_compute_network.vpc.self_link}"
    }
  }

  forwarding_config {
    target_name_servers {
      ipv4_address = "172.16.10.100"
    }
  }
}

resource "google_dns_managed_zone" "private-aws-east1-cloudtuples" {
  provider    = "google-beta"
  name        = "${var.main}private-aws-east1-cloudtuples"
  dns_name    = "east1.cloudtuples.com."
  description = "zone queries to aws east1 region inbound endpoint"
  visibility  = "private"
  labels = {
    foo = "bar"
  }

  private_visibility_config {
    networks {
      network_url = "${google_compute_network.vpc.self_link}"
    }
  }

  forwarding_config {
    target_name_servers {
      ipv4_address = "172.18.10.100"
    }

    target_name_servers {
      ipv4_address = "172.18.11.100"
    }
  }
}

# DNS Policy
resource "google_dns_policy" "allow_inbound" {
  provider                  = "google-beta"
  name                      = "allow-inbound"
  enable_inbound_forwarding = true

  networks {
    network_url = "${google_compute_network.vpc.self_link}"
  }
}
