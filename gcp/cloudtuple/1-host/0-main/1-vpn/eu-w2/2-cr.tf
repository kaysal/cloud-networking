# Cloud routers
resource "google_compute_router" "cr_eu_w2" {
  name    = "${var.main}cr-eu-w2"
  network = "${data.google_compute_network.vpc.self_link}"
  region  = "europe-west2"

  bgp {
    asn               = 65000
    advertise_mode    = "CUSTOM"
    advertised_groups = ["ALL_SUBNETS"]

    # orange project subnet
    advertised_ip_ranges {
      range = "10.200.20.0/24"
    }

    # aws eu-west1-vpc1
    advertised_ip_ranges {
      range = "172.16.0.0/16"
    }

    # aws eu-west1-vpc2
    advertised_ip_ranges {
      range = "172.17.0.0/16"
    }

    # aws eu-east1-vpc1
    advertised_ip_ranges {
      range = "172.18.0.0/16"
    }
  }
}
