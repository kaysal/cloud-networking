# Top-level folders under an organization
#-------------------------------
resource "google_folder" "netsec_folder" {
  display_name = "${var.name}netsec-folder"
  parent     = "organizations/${var.org_id}"
}

resource "google_folder" "prod_folder" {
  display_name = "${var.name}prod-folder"
  parent     = "organizations/${var.org_id}"
}

resource "google_folder" "test_folder" {
  display_name = "${var.name}test-folder"
  parent     = "organizations/${var.org_id}"
}

# folder project owner role to allow authorized groups
# to be project owners on all projects in the folder
#-------------------------------
resource "google_folder_iam_policy" "netsec_folder" {
  folder  = "${google_folder.netsec_folder.name}"
  policy_data = "${data.google_iam_policy.netsec_folder_policy.policy_data}"
}

data "google_iam_policy" "netsec_folder_policy" {
  binding {
    role = "roles/owner"
    members = [
      "group:netsec-grp@cloudtuple.com",
    ]
  }

  binding {
    role    = "roles/resourcemanager.folderEditor"
    members = [
      "group:netsec-grp@cloudtuple.com",
    ]
  }
}


resource "google_folder_iam_policy" "prod_folder" {
  folder  = "${google_folder.prod_folder.name}"
  policy_data = "${data.google_iam_policy.prod_folder_policy.policy_data}"
}

data "google_iam_policy" "prod_folder_policy" {
  binding {
    role = "roles/owner"
    members = [
      "group:prod-grp@cloudtuple.com",
    ]
  }

  binding {
    role    = "roles/resourcemanager.folderEditor"
    members = [
      "group:prod-grp@cloudtuple.com",
    ]
  }
}

resource "google_folder_iam_policy" "test_folder" {
  folder  = "${google_folder.test_folder.name}"
  policy_data = "${data.google_iam_policy.test_folder_policy.policy_data}"
}

data "google_iam_policy" "test_folder_policy" {
  binding {
    role = "roles/owner"
    members = [
      "group:test-grp@cloudtuple.com",
    ]
  }

  binding {
    role    = "roles/resourcemanager.folderEditor"
    members = [
      "group:test-grp@cloudtuple.com",
    ]
  }
}
