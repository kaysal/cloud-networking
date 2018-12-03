# Cloud routers
resource "google_compute_router" "us_e1_cr1" {
  name    = "${var.name}us-e1-cr1"
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

    # restricted google api rangxe
    advertised_ip_ranges {
      range = "199.36.153.4/30"
    }

    # vpcuser16project ip range
    advertised_ip_ranges {
      range = "10.200.10.0/24"
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
