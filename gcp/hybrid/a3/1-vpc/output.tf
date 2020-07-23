
output "vpc" {
  value = {
    vpc = google_compute_network.vpc
    subnet = {
      ovpn  = google_compute_subnetwork.ovpn
      gclb  = google_compute_subnetwork.gclb
      ilb   = google_compute_subnetwork.ilb
      tcp   = google_compute_subnetwork.tcp
      proxy = google_compute_subnetwork.proxy
    }
    ip = {
      ovpn_ext_ip = google_compute_address.ovpn_ext_ip
      gclb_vip    = google_compute_global_address.gclb_vip
      tcp_vip     = google_compute_global_address.tcp_vip
    }
  }
  sensitive = true
}
