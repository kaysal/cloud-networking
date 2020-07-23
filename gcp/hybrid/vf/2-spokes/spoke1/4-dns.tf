
# customer 1
#-------------------------------------

# zone = googleapis.com.

resource "google_dns_managed_zone" "googleapis" {
  provider    = google-beta
  name        = "${var.global.prefix}googleapis"
  dns_name    = "googleapis.com."
  description = "googleapis private zone"
  visibility  = "private"

  private_visibility_config {
    networks {
      network_url = google_compute_network.spoke1.self_link
    }
  }
}

# zone = gcr.io

resource "google_dns_managed_zone" "private_gcr_io" {
  provider    = google-beta
  name        = "${var.global.prefix}private-gcr-io"
  dns_name    = "gcr.io."
  description = "gcr.io private zone"
  visibility  = "private"

  private_visibility_config {
    networks {
      network_url = google_compute_network.spoke1.self_link
    }
  }
}

# restricted.googleapis.com is used for APIs for VPC SC

resource "google_dns_record_set" "restricted_googleapis_cname" {
  count        = length(var.restricted_apis)
  name         = "${element(var.restricted_apis, count.index)}.${google_dns_managed_zone.googleapis.dns_name}"
  type         = "CNAME"
  ttl          = 300
  managed_zone = google_dns_managed_zone.googleapis.name
  rrdatas      = ["restricted.${google_dns_managed_zone.googleapis.dns_name}"]
}

resource "google_dns_record_set" "restricted_googleapis" {
  project = var.project_id_spoke1
  name    = "restricted.${google_dns_managed_zone.googleapis.dns_name}"
  type    = "A"
  ttl     = 300

  managed_zone = google_dns_managed_zone.googleapis.name

  rrdatas = [
    "199.36.153.4",
    "199.36.153.5",
    "199.36.153.6",
    "199.36.153.7",
  ]
}

# restricted.googleapis.com is used for gcr.io

resource "google_dns_record_set" "gcr_io_cname" {
  name = "*.gcr.io."
  type = "CNAME"
  ttl  = 300

  managed_zone = google_dns_managed_zone.private_gcr_io.name
  rrdatas      = ["gcr.io."]
}

resource "google_dns_record_set" "restricted_gcr_io" {
  project = var.project_id_spoke1
  name    = "gcr.io."
  type    = "A"
  ttl     = 300

  managed_zone = google_dns_managed_zone.private_gcr_io.name

  rrdatas = [
    "199.36.153.4",
    "199.36.153.5",
    "199.36.153.6",
    "199.36.153.7",
  ]
}

# 8.8.8.8, 8.8.4.4 is used for www.googleapis.com

resource "google_dns_managed_zone" "private_www_googleapis" {
  provider    = google-beta
  name        = "${var.global.prefix}www-googleapis"
  dns_name    = "www.${google_dns_managed_zone.googleapis.dns_name}"
  description = "resolve googleapis.com via 8.8.8.8"
  visibility  = "private"

  private_visibility_config {
    networks {
      network_url = google_compute_network.spoke1.self_link
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
