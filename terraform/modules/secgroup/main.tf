locals {
  rules = {
    http = {
      protocol       = "tcp"
      port_range_min = 80
      port_range_max = 80
      description    = "Allow HTTP traffic"
    }
    https = {
      protocol       = "tcp"
      port_range_min = 443
      port_range_max = 443
      description    = "Allow HTTPS traffic"
    }
    ssh = {
      protocol       = "tcp"
      port_range_min = 22
      port_range_max = 22
      description    = "Allow SSH traffic"
    }
    postgres = {
      protocol       = "tcp"
      port_range_min = 5432
      port_range_max = 5432
      description    = "Allow Postgres traffic"
    }
  }
}

resource "openstack_networking_secgroup_v2" "secgoup" {
  name        = var.name
  description = var.description
}

resource "openstack_networking_secgroup_rule_v2" "rule" {
  for_each          = var.types
  description       = local.rules[each.key].description
  security_group_id = openstack_networking_secgroup_v2.secgoup.id
  direction         = var.direction
  ethertype         = var.ethertype
  protocol          = local.rules[each.key].protocol
  port_range_max    = local.rules[each.key].port_range_max
  port_range_min    = local.rules[each.key].port_range_min
}
