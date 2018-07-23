# random id
resource "random_id" "cert" {
  byte_length = 2
}

# certificate and private key for prod lb
resource "google_compute_ssl_certificate" "prod_gcpdemo_solutions" {
  name = "${var.name}prod-gcpdemo-solutions-${random_id.cert.hex}"
  private_key = "${file("${var.private_key_path_prod}")}"
  certificate = "${file("${var.crt_path_prod}")}"

  lifecycle {
    create_before_destroy = true
  }

}

# certificate and private key for dev lb
resource "google_compute_ssl_certificate" "dev_gcpdemo_solutions" {
  name = "${var.name}dev-gcpdemo-solutions-${random_id.cert.hex}"
  private_key = "${file("${var.private_key_path_dev}")}"
  certificate = "${file("${var.crt_path_dev}")}"

  lifecycle {
    create_before_destroy = true
  }

}
