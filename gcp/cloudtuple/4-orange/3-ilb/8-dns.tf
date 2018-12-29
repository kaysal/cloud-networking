data "google_dns_managed_zone" "cloudtuple_public" {
  name = "public-orange-cloudtuple"
}

data "google_dns_managed_zone" "cloudtuple_private" {
  name = "private-orange-cloudtuple"
}
