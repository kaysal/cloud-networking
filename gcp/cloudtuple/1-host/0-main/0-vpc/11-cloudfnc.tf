# create a regional bucket in europe-west1
resource "google_storage_bucket" "cloud_function" {
  name          = "cloud-fnc-${data.terraform_remote_state.host.outputs.host_project_id}"
  location      = "europe-west1"
  force_destroy = true
  storage_class = "REGIONAL"
}

# hello world

resource "google_storage_bucket_object" "hello_world" {
  name   = "hello.zip"
  source = "./objects/hello.zip"
  bucket = google_storage_bucket.cloud_function.name
}

resource "google_cloudfunctions_function" "hello_world" {
  region      = "europe-west1"
  name        = "hello"
  description = "hello world"
  runtime     = "nodejs8"

  available_memory_mb   = 256
  source_archive_bucket = google_storage_bucket.cloud_function.name
  source_archive_object = google_storage_bucket_object.hello_world.name
  trigger_http          = true
  timeout               = 60
  entry_point           = "helloWorld"

  labels = {
    app = "hello"
  }

  environment_variables = {
    PROJECT = data.terraform_remote_state.host.outputs.host_project_id
  }
}

output "cfn_hello_world" {
  value = google_cloudfunctions_function.hello_world.https_trigger_url
}

# ifconfig

resource "google_storage_bucket_object" "ifconfig" {
  name   = "ifconfig.zip"
  source = "./objects/ifconfig.zip"
  bucket = google_storage_bucket.cloud_function.name
}

resource "google_cloudfunctions_function" "ifconfig" {
  region      = "us-central1"
  name        = "ifconfig"
  description = "ifconfig"
  runtime     = "nodejs8"

  available_memory_mb   = 256
  source_archive_bucket = google_storage_bucket.cloud_function.name
  source_archive_object = google_storage_bucket_object.ifconfig.name
  trigger_http          = true
  timeout               = 60
  entry_point           = "ifconfig"

  labels = {
    app = "ifconfig"
  }

  environment_variables = {
    PROJECT = data.terraform_remote_state.host.outputs.host_project_id
  }
}

output "cfn_ifconfig" {
  value = google_cloudfunctions_function.ifconfig.https_trigger_url
}

# serverless

resource "google_storage_bucket_object" "serverless" {
  name   = "serverless.zip"
  source = "./objects/serverless.zip"
  bucket = google_storage_bucket.cloud_function.name
}

resource "google_cloudfunctions_function" "serverless" {
  region      = "us-central1"
  name        = "serverless"
  description = "serverless"
  runtime     = "nodejs8"

  available_memory_mb   = 256
  source_archive_bucket = google_storage_bucket.cloud_function.name
  source_archive_object = google_storage_bucket_object.serverless.name
  trigger_http          = true
  timeout               = 60
  entry_point           = "serverless"

  labels = {
    app = "serverless"
  }

  environment_variables = {
    PROJECT = data.terraform_remote_state.host.outputs.host_project_id
  }
}

output "cfn_serverless" {
  value = google_cloudfunctions_function.serverless.https_trigger_url
}

