terraform {
  required_version = ">= 1.10.3"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 3.3.2"
    }

  }
  backend "http" {
    address        = "https://gitlab.stud.idi.ntnu.no/api/v4/projects/30980/terraform/state/nix-image"
    lock_address   = "https://gitlab.stud.idi.ntnu.no/api/v4/projects/30980/terraform/state/nix-image/lock"
    unlock_address = "https://gitlab.stud.idi.ntnu.no/api/v4/projects/30980/terraform/state/nix-image/lock"
    lock_method    = "POST"
    unlock_method  = "DELETE"
    retry_wait_min = 5
  }
}

provider "openstack" {
  auth_url         = "https://api.skyhigh.iik.ntnu.no:5000/v3"
  user_domain_name = "NTNU"
}
