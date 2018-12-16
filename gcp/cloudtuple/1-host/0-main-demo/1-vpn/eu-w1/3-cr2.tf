# Cloud Router 2
#------------------------------
resource "google_compute_router" "eu_w1_cr2" {
  name    = "${var.name}eu-w1-cr2"
  network = "${data.terraform_remote_state.vpc.vpc}"
  region  = "europe-west1"

  bgp {
    asn               = 65000
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

    # lzone1 ip range
    advertised_ip_ranges {
      range = "10.200.20.0/24"
    }

    # lzone2 ip range
    advertised_ip_ranges {
      range = "10.200.30.0/24"
    }
  }
}
