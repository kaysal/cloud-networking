# GKE Ingress GCLB IP Address
#--------------------------------------
resource "google_compute_global_address" "gke_php_ingress_ip" {
  name        = "gke-php-ingress-ip"
  description = "static ipv4 address for gclb frontend"
}
