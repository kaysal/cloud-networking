# Cloud routers
resource "google_compute_router" "cr_eu_w2" {
  name    = "${var.main}cr-eu-w2"
  network = data.google_compute_network.vpc.self_link
  region  = "europe-west2"

  bgp {
    asn               = 65000
    advertise_mode    = "CUSTOM"
    advertised_groups = ["ALL_SUBNETS"]

    # orange project subnet
    advertised_ip_ranges {
      range = "10.200.20.0/24"
    }

    # rfc1918
    advertised_ip_ranges {
      range = "10.0.0.0/8"
    }

    # rfc1918
    advertised_ip_ranges {
      range = "172.16.0.0/12"
    }

    # rfc1918
    advertised_ip_ranges {
      range = "192.168.0.0/16"
    }

    # cgn
    advertised_ip_ranges {
      range = "100.64.0.0/10"
    }
  }
}

