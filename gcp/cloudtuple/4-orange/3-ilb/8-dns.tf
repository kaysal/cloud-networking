data "google_dns_managed_zone" "public_orange_cloudtuple" {
  name = "public-orange-cloudtuple"
}

data "google_dns_managed_zone" "private_orange_cloudtuple" {
  name = "private-orange-cloudtuple"
}
