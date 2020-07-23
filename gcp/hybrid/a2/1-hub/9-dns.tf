
# trust1
#-------------------------------------

# inbound dns

resource "google_dns_policy" "trust1_inbound" {
  provider                  = google-beta
  project                   = var.project_id_hub
  name                      = "${local.prefix_trust1}inbound"
  enable_inbound_forwarding = "true"
  enable_logging            = "true"

  networks {
    network_url = google_compute_network.trust1.self_link
  }
}

# private zone for spoke1 VPC

resource "google_dns_managed_zone" "trust1_spoke1" {
  provider    = google-beta
  project     = var.project_id_hub
  name        = "${local.prefix_trust1}spoke1"
  dns_name    = "spoke1.lab."
  description = "spoke1.lab > local"
  visibility  = "private"

  private_visibility_config {
    networks {
      network_url = google_compute_network.trust1.self_link
    }
  }
}

# A Records

resource "google_dns_record_set" "trust1_spoke1_web80" {
  project = var.project_id_hub
  name    = "web80.spoke1.lab."
  type    = "A"
  ttl     = 300

  managed_zone = google_dns_managed_zone.trust1_spoke1.name
  rrdatas      = [var.hub.trust1.ip.web80]
}

resource "google_dns_record_set" "trust1_spoke1_web81" {
  project = var.project_id_hub
  name    = "web81.spoke1.lab."
  type    = "A"
  ttl     = 300

  managed_zone = google_dns_managed_zone.trust1_spoke1.name
  rrdatas      = [var.hub.trust1.ip.web81]
}

# zone = googleapis.com.

resource "google_dns_managed_zone" "trust1_googleapis" {
  provider    = google-beta
  project     = var.project_id_hub
  name        = "${local.prefix_trust1}googleapis"
  dns_name    = "googleapis.com."
  description = "googleapis private zone"
  visibility  = "private"

  private_visibility_config {
    networks {
      network_url = google_compute_network.trust1.self_link
    }
  }
}

# zone = gcr.io

resource "google_dns_managed_zone" "trust1_private_gcr_io" {
  provider    = google-beta
  project     = var.project_id_hub
  name        = "${local.prefix_trust1}private-gcr-io"
  dns_name    = "gcr.io."
  description = "gcr.io private zone"
  visibility  = "private"

  private_visibility_config {
    networks {
      network_url = google_compute_network.trust1.self_link
    }
  }
}

# restricted.googleapis.com is used for APIs for VPC SC

resource "google_dns_record_set" "trust1_restricted_googleapis_cname" {
  project      = var.project_id_hub
  count        = length(var.restricted_apis)
  name         = "${element(var.restricted_apis, count.index)}.${google_dns_managed_zone.trust1_googleapis.dns_name}"
  type         = "CNAME"
  ttl          = 300
  managed_zone = google_dns_managed_zone.trust1_googleapis.name
  rrdatas      = ["restricted.${google_dns_managed_zone.trust1_googleapis.dns_name}"]
}

resource "google_dns_record_set" "trust1_restricted_googleapis" {
  project = var.project_id_hub
  name    = "restricted.${google_dns_managed_zone.trust1_googleapis.dns_name}"
  type    = "A"
  ttl     = 300

  managed_zone = google_dns_managed_zone.trust1_googleapis.name

  rrdatas = [
    "199.36.153.4",
    "199.36.153.5",
    "199.36.153.6",
    "199.36.153.7",
  ]
}

# restricted.googleapis.com is used for gcr.io

resource "google_dns_record_set" "trust1_gcr_io_cname" {
  project = var.project_id_hub
  name    = "*.gcr.io."
  type    = "CNAME"
  ttl     = 300

  managed_zone = google_dns_managed_zone.trust1_private_gcr_io.name
  rrdatas      = ["gcr.io."]
}

resource "google_dns_record_set" "trust1_restricted_gcr_io" {
  project = var.project_id_hub
  name    = "gcr.io."
  type    = "A"
  ttl     = 300

  managed_zone = google_dns_managed_zone.trust1_private_gcr_io.name

  rrdatas = [
    "199.36.153.4",
    "199.36.153.5",
    "199.36.153.6",
    "199.36.153.7",
  ]
}

# 8.8.8.8, 8.8.4.4 is used for www.googleapis.com

resource "google_dns_managed_zone" "trust1_private_www_googleapis" {
  provider    = google-beta
  project     = var.project_id_hub
  name        = "${local.prefix_trust1}www-googleapis"
  dns_name    = "www.${google_dns_managed_zone.trust1_googleapis.dns_name}"
  description = "resolve googleapis.com via 8.8.8.8"
  visibility  = "private"

  private_visibility_config {
    networks {
      network_url = google_compute_network.trust1.self_link
    }
  }

  forwarding_config {
    target_name_servers {
      ipv4_address = "8.8.8.8"
    }
    target_name_servers {
      ipv4_address = "8.8.4.4"
    }
  }
}

# trust2
#-------------------------------------

# inbound dns

resource "google_dns_policy" "trust2_inbound" {
  provider                  = google-beta
  project                   = var.project_id_hub
  name                      = "${local.prefix_trust2}inbound"
  enable_inbound_forwarding = "true"
  enable_logging            = "true"

  networks {
    network_url = google_compute_network.trust2.self_link
  }
}

# private zone for spoke2 VPC

resource "google_dns_managed_zone" "trust2_spoke2" {
  provider    = google-beta
  project     = var.project_id_hub
  name        = "${local.prefix_trust2}spoke2"
  dns_name    = "spoke2.lab."
  description = "spoke2.lab > local"
  visibility  = "private"

  private_visibility_config {
    networks {
      network_url = google_compute_network.trust2.self_link
    }
  }
}

# A Records

resource "google_dns_record_set" "trust2_spoke2_web80" {
  project = var.project_id_hub
  name    = "web80.spoke2.lab."
  type    = "A"
  ttl     = 300

  managed_zone = google_dns_managed_zone.trust2_spoke2.name
  rrdatas      = [var.hub.trust2.ip.web80]
}

resource "google_dns_record_set" "trust2_spoke2_web81" {
  project = var.project_id_hub
  name    = "web81.spoke2.lab."
  type    = "A"
  ttl     = 300

  managed_zone = google_dns_managed_zone.trust2_spoke2.name
  rrdatas      = [var.hub.trust2.ip.web81]
}

# zone = googleapis.com.

resource "google_dns_managed_zone" "trust2_googleapis" {
  provider    = google-beta
  project     = var.project_id_hub
  name        = "${local.prefix_trust2}googleapis"
  dns_name    = "googleapis.com."
  description = "googleapis private zone"
  visibility  = "private"

  private_visibility_config {
    networks {
      network_url = google_compute_network.trust2.self_link
    }
  }
}

# zone = gcr.io

resource "google_dns_managed_zone" "trust2_private_gcr_io" {
  provider    = google-beta
  project     = var.project_id_hub
  name        = "${local.prefix_trust2}private-gcr-io"
  dns_name    = "gcr.io."
  description = "gcr.io private zone"
  visibility  = "private"

  private_visibility_config {
    networks {
      network_url = google_compute_network.trust2.self_link
    }
  }
}

# restricted.googleapis.com is used for APIs for VPC SC

resource "google_dns_record_set" "trust2_restricted_googleapis_cname" {
  project      = var.project_id_hub
  count        = length(var.restricted_apis)
  name         = "${element(var.restricted_apis, count.index)}.${google_dns_managed_zone.trust2_googleapis.dns_name}"
  type         = "CNAME"
  ttl          = 300
  managed_zone = google_dns_managed_zone.trust2_googleapis.name
  rrdatas      = ["restricted.${google_dns_managed_zone.trust2_googleapis.dns_name}"]
}

resource "google_dns_record_set" "trust2_restricted_googleapis" {
  project = var.project_id_hub
  name    = "restricted.${google_dns_managed_zone.trust2_googleapis.dns_name}"
  type    = "A"
  ttl     = 300

  managed_zone = google_dns_managed_zone.trust2_googleapis.name

  rrdatas = [
    "199.36.153.4",
    "199.36.153.5",
    "199.36.153.6",
    "199.36.153.7",
  ]
}

# restricted.googleapis.com is used for gcr.io

resource "google_dns_record_set" "trust2_gcr_io_cname" {
  project = var.project_id_hub
  name    = "*.gcr.io."
  type    = "CNAME"
  ttl     = 300

  managed_zone = google_dns_managed_zone.trust2_private_gcr_io.name
  rrdatas      = ["gcr.io."]
}

resource "google_dns_record_set" "trust2_restricted_gcr_io" {
  project = var.project_id_hub
  name    = "gcr.io."
  type    = "A"
  ttl     = 300

  managed_zone = google_dns_managed_zone.trust2_private_gcr_io.name

  rrdatas = [
    "199.36.153.4",
    "199.36.153.5",
    "199.36.153.6",
    "199.36.153.7",
  ]
}

# 8.8.8.8, 8.8.4.4 is used for www.googleapis.com

resource "google_dns_managed_zone" "trust2_private_www_googleapis" {
  provider    = google-beta
  project     = var.project_id_hub
  name        = "${local.prefix_trust2}www-googleapis"
  dns_name    = "www.${google_dns_managed_zone.trust2_googleapis.dns_name}"
  description = "resolve googleapis.com via 8.8.8.8"
  visibility  = "private"

  private_visibility_config {
    networks {
      network_url = google_compute_network.trust2.self_link
    }
  }

  forwarding_config {
    target_name_servers {
      ipv4_address = "8.8.8.8"
    }
    target_name_servers {
      ipv4_address = "8.8.4.4"
    }
  }
}
