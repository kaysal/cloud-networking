# GKE Ingress GCLB IP Address
#--------------------------------------
resource "google_compute_global_address" "gke_hello_ingress_w1_ip" {
  name        = "gke-hello-ingress-w1-ip"
  description = "static ipv4 address for gclb frontend"
}
