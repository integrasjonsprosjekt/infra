terraform {
  required_version = ">= 1.10.3"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 3.3.2"
    }

  }
  backend "pg" {
    schema_name = "terraform_remote_state_main"
  }
}

provider "openstack" {
  auth_url         = "https://api.skyhigh.iik.ntnu.no:5000/v3"
  user_domain_name = "NTNU"
}
