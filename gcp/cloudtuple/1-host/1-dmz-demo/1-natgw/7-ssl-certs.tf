# random id
resource "random_id" "cert" {
  byte_length = 2
}

# certificate and private key for prod backend service
# ipv4
resource "google_compute_ssl_certificate" "prod_cert" {
  name = "${var.name}prod-cert-${random_id.cert.hex}"
  private_key = "${file("${var.priv_key_path_prod}")}"
  certificate = "${file("${var.crt_path_prod}")}"

  lifecycle {
    create_before_destroy = true
  }
}

# ipv6
resource "google_compute_ssl_certificate" "prod_cert_v6" {
  name = "${var.name}prod-cert-v6-${random_id.cert.hex}"
  private_key = "${file("${var.priv_key_path_prod_v6}")}"
  certificate = "${file("${var.crt_path_prod_v6}")}"

  lifecycle {
    create_before_destroy = true
  }
}

# certificate and private key for dev backend service
# ipv4
resource "google_compute_ssl_certificate" "dev_cert" {
  name = "${var.name}dev-cert-${random_id.cert.hex}"
  private_key = "${file("${var.priv_key_path_dev}")}"
  certificate = "${file("${var.crt_path_dev}")}"

  lifecycle {
    create_before_destroy = true
  }
}

# ipv6
resource "google_compute_ssl_certificate" "dev_cert_v6" {
  name = "${var.name}dev-cert-v6-${random_id.cert.hex}"
  private_key = "${file("${var.priv_key_path_dev_v6}")}"
  certificate = "${file("${var.crt_path_dev_v6}")}"

  lifecycle {
    create_before_destroy = true
  }
}
