resource "random_id" "random" {
  byte_length = 2
}


resource "google_storage_bucket" "prod_storage_bucket" {
  name     = "prod-storage-bucket-${random_id.random.hex}"
  location = "US"
  force_destroy = true
  storage_class = "MULTI_REGIONAL"
}
