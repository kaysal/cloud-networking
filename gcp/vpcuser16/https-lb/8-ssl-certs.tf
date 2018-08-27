# random id
resource "random_id" "cert" {
  byte_length = 2
}

# certificate and private key for prod backend service
resource "google_compute_ssl_certificate" "prod_cert" {
  name = "${var.name}prod-cert-${random_id.cert.hex}"
  private_key = "${file("${var.priv_key_path_prod}")}"
  certificate = "${file("${var.crt_path_prod}")}"

  lifecycle {
    create_before_destroy = true
  }
}

# certificate and private key for dev backend service
resource "google_compute_ssl_certificate" "dev_cert" {
  name = "${var.name}dev-cert-${random_id.cert.hex}"
  private_key = "${file("${var.priv_key_path_dev}")}"
  certificate = "${file("${var.crt_path_dev}")}"

  lifecycle {
    create_before_destroy = true
  }
}
