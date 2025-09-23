terraform {
  required_version = ">= 1.10.3"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 3.3.2"
    }

  }
  backend "http" {
    address        = "https://gitlab.stud.idi.ntnu.no/api/v4/projects/30980/terraform/state/infra"
    lock_address   = "https://gitlab.stud.idi.ntnu.no/api/v4/projects/30980/terraform/state/infra/lock"
    unlock_address = "https://gitlab.stud.idi.ntnu.no/api/v4/projects/30980/terraform/state/infra/lock"
  }
}

provider "openstack" {
}