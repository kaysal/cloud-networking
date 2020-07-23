
# inbound dns

resource "google_dns_policy" "spoke2_inbound" {
  provider                  = google-beta
  project                   = var.project_id_spoke2
  name                      = "${var.global.prefix}${var.spoke2.prefix}inbound"
  enable_inbound_forwarding = "true"
  enable_logging            = "true"

  networks {
    network_url = google_compute_network.spoke2_vpc.self_link
  }
}

# private zone for spoke2 VPC

resource "google_dns_managed_zone" "spoke2_internal" {
  provider    = google-beta
  project     = var.project_id_spoke2
  name        = "${var.global.prefix}${var.spoke2.prefix}internal"
  dns_name    = "spoke2.lab."
  description = "spoke2.lab > local"
  visibility  = "private"

  private_visibility_config {
    networks {
      network_url = google_compute_network.spoke2_vpc.self_link
    }
  }
}

# A Records

resource "google_dns_record_set" "web80_record" {
  project = var.project_id_spoke2
  name    = "web80.spoke2.lab."
  type    = "A"
  ttl     = 300

  managed_zone = google_dns_managed_zone.spoke2_internal.name
  rrdatas      = [var.spoke2.ip.web80]
}

resource "google_dns_record_set" "web81_record" {
  project = var.project_id_spoke2
  name    = "web81.spoke2.lab."
  type    = "A"
  ttl     = 300

  managed_zone = google_dns_managed_zone.spoke2_internal.name
  rrdatas      = [var.spoke2.ip.web81]
}

# zone = googleapis.com.

resource "google_dns_managed_zone" "spoke2_googleapis" {
  provider    = google-beta
  project     = var.project_id_spoke2
  name        = "${var.global.prefix}${var.spoke2.prefix}googleapis"
  dns_name    = "googleapis.com."
  description = "googleapis private zone"
  visibility  = "private"

  private_visibility_config {
    networks {
      network_url = google_compute_network.spoke2_vpc.self_link
    }
  }
}

# zone = gcr.io

resource "google_dns_managed_zone" "spoke2_private_gcr_io" {
  provider    = google-beta
  project     = var.project_id_spoke2
  name        = "${var.global.prefix}${var.spoke2.prefix}private-gcr-io"
  dns_name    = "gcr.io."
  description = "gcr.io private zone"
  visibility  = "private"

  private_visibility_config {
    networks {
      network_url = google_compute_network.spoke2_vpc.self_link
    }
  }
}

# restricted.googleapis.com is used for APIs for VPC SC

resource "google_dns_record_set" "spoke2_restricted_googleapis_cname" {
  project      = var.project_id_spoke2
  count        = length(var.restricted_apis)
  name         = "${element(var.restricted_apis, count.index)}.${google_dns_managed_zone.spoke2_googleapis.dns_name}"
  type         = "CNAME"
  ttl          = 300
  managed_zone = google_dns_managed_zone.spoke2_googleapis.name
  rrdatas      = ["restricted.${google_dns_managed_zone.spoke2_googleapis.dns_name}"]
}

resource "google_dns_record_set" "spoke2_restricted_googleapis" {
  project = var.project_id_spoke2
  name    = "restricted.${google_dns_managed_zone.spoke2_googleapis.dns_name}"
  type    = "A"
  ttl     = 300

  managed_zone = google_dns_managed_zone.spoke2_googleapis.name

  rrdatas = [
    "199.36.153.4",
    "199.36.153.5",
    "199.36.153.6",
    "199.36.153.7",
  ]
}

# restricted.googleapis.com is used for gcr.io

resource "google_dns_record_set" "spoke2_gcr_io_cname" {
  project = var.project_id_spoke2
  name    = "*.gcr.io."
  type    = "CNAME"
  ttl     = 300

  managed_zone = google_dns_managed_zone.spoke2_private_gcr_io.name
  rrdatas      = ["gcr.io."]
}

resource "google_dns_record_set" "spoke2_restricted_gcr_io" {
  project = var.project_id_spoke2
  name    = "gcr.io."
  type    = "A"
  ttl     = 300

  managed_zone = google_dns_managed_zone.spoke2_private_gcr_io.name

  rrdatas = [
    "199.36.153.4",
    "199.36.153.5",
    "199.36.153.6",
    "199.36.153.7",
  ]
}

# 8.8.8.8, 8.8.4.4 is used for www.googleapis.com

resource "google_dns_managed_zone" "spoke2_private_www_googleapis" {
  provider    = google-beta
  project     = var.project_id_spoke2
  name        = "${var.spoke2.prefix}www-googleapis"
  dns_name    = "www.${google_dns_managed_zone.spoke2_googleapis.dns_name}"
  description = "resolve googleapis.com via 8.8.8.8"
  visibility  = "private"

  private_visibility_config {
    networks {
      network_url = google_compute_network.spoke2_vpc.self_link
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

/*
# private.googleapis.com is used for all other googleapis

resource "google_dns_record_set" "spoke2_private_googleapis_cname" {
  project      = var.project_id_spoke2
  name         = "*.${google_dns_managed_zone.spoke2_googleapis.dns_name}"
  type         = "CNAME"
  ttl          = 300
  managed_zone = google_dns_managed_zone.spoke2_googleapis.name
  rrdatas      = ["private.${google_dns_managed_zone.spoke2_googleapis.dns_name}"]
}

resource "google_dns_record_set" "spoke2_private_googleapis" {
  project = var.project_id_spoke2
  name    = "private.${google_dns_managed_zone.spoke2_googleapis.dns_name}"
  type    = "A"
  ttl     = 300

  managed_zone = google_dns_managed_zone.spoke2_googleapis.name

  rrdatas = [
    "199.36.153.8",
    "199.36.153.9",
    "199.36.153.10",
    "199.36.153.11",
  ]
}*/
