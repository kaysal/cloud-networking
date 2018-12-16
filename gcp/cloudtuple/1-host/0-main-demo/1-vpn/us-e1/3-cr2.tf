# Cloud routers
resource "google_compute_router" "us_e1_cr2" {
  name    = "${var.name}us-e1-cr2"
  network = "${data.terraform_remote_state.vpc.vpc}"
  region = "us-east1"

  bgp {
    asn = 65000
    advertise_mode    = "CUSTOM"
    advertised_groups = ["ALL_SUBNETS"]

    # private dns range
    advertised_ip_ranges {
      range = "35.199.192.0/19"
    }

    # restricted google api range
    advertised_ip_ranges {
      range = "199.36.153.4/30"
    }

    # Orange Project Subnet
    advertised_ip_ranges {
      range = "10.200.20.0/24"
    }

    # Mango Project Subnet
    advertised_ip_ranges {
      range = "10.200.30.0/24"
    }
  }
}
