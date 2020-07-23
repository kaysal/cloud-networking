
output "vpc" {
  value = {
    vpc = google_compute_network.vpc
    subnet = {
      ovpn = google_compute_subnetwork.ovpn
    }
    ip = {
      ovpn_ext_ip = google_compute_address.ovpn_ext_ip
    }
  }
  sensitive = true
}
