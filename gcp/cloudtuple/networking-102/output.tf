output "faux_on_prem_svc_public_ip" {
  value = ["${google_compute_instance.faux_on_prem_svc.network_interface.0.access_config.0.assigned_nat_ip}"]
}

output "nat_gw_us_public_ip" {
  value = ["${google_compute_instance.nat_gw_us.network_interface.0.access_config.0.assigned_nat_ip}"]
}


output "nat_gw_eu_public_ip" {
  value = ["${google_compute_instance.nat_gw_eu.network_interface.0.access_config.0.assigned_nat_ip}"]
}
