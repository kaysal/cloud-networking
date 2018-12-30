data "google_dns_managed_zone" "public_mango_cloudtuple" {
  name = "public-mango-cloudtuple"
}

data "google_dns_managed_zone" "private_mango_cloudtuple" {
  name = "private-mango-cloudtuple"
}
