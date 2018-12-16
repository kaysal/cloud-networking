data "google_dns_managed_zone" "cloudtuple_public" {
  name = "cloudtuple"
}

data "google_dns_managed_zone" "cloudtuple_private" {
  name        = "cloudtuple-private"
}
