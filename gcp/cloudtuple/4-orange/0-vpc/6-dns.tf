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
  rrdatas      = ["restricted.${google_dns_managed_zone.private_googleapis.dns_name}"]
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
    "199.36.153.7",
  ]
}

# Main VPC Private Zone
#--------------------------------
resource "google_dns_managed_zone" "private_orange_cloudtuple" {
  provider    = "google-beta"
  name        = "${var.main}private-orange-cloudtuple"
  dns_name    = "orange.cloudtuple.com."
  description = "private zone for orange project"
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

output "private_orange_cloudtuple_name" {
  value = "${google_dns_managed_zone.private_orange_cloudtuple.name}"
}

# DNS Peering
#===================================
resource "google_project_iam_binding" "dns_peer" {
  provider = "google-beta"
  role     = "roles/dns.peer"

  members = [
    "serviceAccount:${data.terraform_remote_state.host.vm_host_project_service_account_email}",
    "serviceAccount:${data.terraform_remote_state.host.vm_host_project_service_account_email}",
  ]
}

# Peering Zones
#--------------------------------
resource "google_dns_managed_zone" "gcp_host_cloudtuple" {
  provider    = "google-beta"
  name        = "${var.main}gcp-host-cloudtuple"
  dns_name    = "host.cloudtuple.com."
  description = "queries to gcp host private zone"
  visibility  = "private"

  labels = {
    foo = "bar"
  }

  private_visibility_config {
    networks {
      network_url = "${google_compute_network.vpc.self_link}"
    }
  }

  peering_config {
    target_network {
      network_url = "${data.google_compute_network.host_vpc.self_link}"
    }
  }
}

resource "google_dns_managed_zone" "gcp_apple_cloudtuple" {
  provider    = "google-beta"
  name        = "${var.main}gcp-apple-cloudtuple"
  dns_name    = "apple.cloudtuple.com."
  description = "queries to gcp apple private zone"
  visibility  = "private"

  labels = {
    foo = "bar"
  }

  private_visibility_config {
    networks {
      network_url = "${google_compute_network.vpc.self_link}"
    }
  }

  peering_config {
    target_network {
      network_url = "${data.google_compute_network.host_vpc.self_link}"
    }
  }
}

resource "google_dns_managed_zone" "gcp_mango_cloudtuple" {
  provider    = "google-beta"
  name        = "${var.main}gcp-mango-cloudtuple"
  dns_name    = "mango.cloudtuple.com."
  description = "queries to gcp mango private zone"
  visibility  = "private"

  labels = {
    foo = "bar"
  }

  private_visibility_config {
    networks {
      network_url = "${google_compute_network.vpc.self_link}"
    }
  }

  peering_config {
    target_network {
      network_url = "${data.google_compute_network.mango_vpc.self_link}"
    }
  }
}

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

  peering_config {
    target_network {
      network_url = "${data.google_compute_network.host_vpc.self_link}"
    }
  }
}

resource "google_dns_managed_zone" "private_aws_east1_cloudtuples" {
  provider    = "google-beta"
  name        = "${var.main}private-aws-east1-cloudtuples"
  dns_name    = "east1.cloudtuples.com."
  description = "zone queries to aws east1 region"
  visibility  = "private"

  labels = {
    foo = "bar"
  }

  private_visibility_config {
    networks {
      network_url = "${google_compute_network.vpc.self_link}"
    }
  }

  peering_config {
    target_network {
      network_url = "${data.google_compute_network.host_vpc.self_link}"
    }
  }
}

# DNS Policy
#--------------------------------
resource "google_dns_policy" "inbound_policy" {
  provider                  = "google-beta"
  name                      = "inbound-policy"
  enable_inbound_forwarding = true

  networks {
    network_url = "${google_compute_network.vpc.self_link}"
  }
}
