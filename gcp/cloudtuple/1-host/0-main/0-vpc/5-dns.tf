# APPLE PROJECT
# netsec-grp@ has DNS admin role for Organisation
# and can create DNS zones in any Org Project
# so you can run 'terraform destroy' on service project without
# deleting the zones and risk getting new name server shards
#============================

# Public DNS
#-------------------------
resource "google_dns_managed_zone" "public_host_cloudtuple" {
  project    = "${data.terraform_remote_state.host.host_project_id}"
  name        = "public-host-cloudtuple"
  dns_name    = "cloudtuple.com."
  description = "Host and Apple projects Public Second Level Domain"
}

resource "google_dns_managed_zone" "public_orange_cloudtuple" {
  project    = "${data.terraform_remote_state.orange.orange_project_id}"
  name        = "public-orange-cloudtuple"
  dns_name    = "orange.cloudtuple.com."
  description = "Orange Public Second Level Domain"
}

resource "google_dns_managed_zone" "public_mango_cloudtuple" {
  project    = "${data.terraform_remote_state.mango.mango_project_id}"
  name        = "public-mango-cloudtuple"
  dns_name    = "mango.cloudtuple.com."
  description = "Mango Public Second Level Domain"
}


# Private DNS
#-------------------------
resource "google_dns_managed_zone" "private_googleapis" {
  provider = "google-beta"
  name = "${var.name}private-googleapis"
  dns_name = "googleapis.com."
  description = "private zone for googleapis"
  visibility = "private"

  private_visibility_config {
    networks {
      network_url =  "${google_compute_network.vpc.self_link}"
    }
  }
}

resource "google_dns_managed_zone" "private_host_cloudtuple" {
  provider = "google-beta"
  name = "${var.name}private-host-cloudtuple"
  dns_name = "host.cloudtuple.com."
  description = "private zone for host project"
  visibility = "private"

  private_visibility_config {
    networks {
      network_url =  "${google_compute_network.vpc.self_link}"
    }
  }
}

resource "google_dns_managed_zone" "private_apple_cloudtuple" {
  provider = "google-beta"
  name = "${var.name}private-apple-cloudtuple"
  dns_name = "apple.cloudtuple.com."
  description = "private zone for apple project"
  visibility = "private"

  private_visibility_config {
    networks {
      network_url =  "${google_compute_network.vpc.self_link}"
    }
  }
}

resource "google_dns_managed_zone" "private_gke_cloudtuple" {
  provider = "google-beta"
  name = "${var.name}private-gke-cloudtuple"
  dns_name = "gke.cloudtuple.com."
  description = "private zone for gke project"
  visibility = "private"

  private_visibility_config {
    networks {
      network_url =  "${google_compute_network.vpc.self_link}"
    }
  }
}

resource "google_dns_managed_zone" "private_aws_west1_cloudtuples" {
  provider = "google-beta"
  name = "${var.name}private-aws-west1-cloudtuples"
  dns_name = "west1.cloudtuples.com."
  description = "zone queries to aws west1 region"
  visibility = "private"

  private_visibility_config {
    networks {
      network_url =  "${google_compute_network.vpc.self_link}"
    }
  }

  forwarding_config {
    target_name_servers {
      ipv4_address = "172.16.10.100"
    }
  }
}

resource "google_dns_managed_zone" "private-aws-east1-cloudtuples" {
  provider = "google-beta"
  name = "${var.name}private-aws-east1-cloudtuples"
  dns_name = "east1.cloudtuples.com."
  description = "zone queries to aws east1 region inbound endpoint"
  visibility = "private"

  private_visibility_config {
    networks {
      network_url =  "${google_compute_network.vpc.self_link}"
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
