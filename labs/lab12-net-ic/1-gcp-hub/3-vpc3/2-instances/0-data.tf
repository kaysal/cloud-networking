
data "terraform_remote_state" "vpc3" {
  backend = "local"

  config = {
    path = "../../3-vpc3/1-vpc/terraform.tfstate"
  }
}
