resource "openstack_networking_network_v2" "network" {
  name = var.name
}

resource "openstack_networking_subnet_v2" "subnet" {
  for_each    = var.subnet_cidr
  name        = "${var.name}-subnet-${each.key}"
  network_id  = openstack_networking_network_v2.network.id
  cidr        = each.value
  ip_version  = 4
  enable_dhcp = true
}

resource "openstack_networking_router_v2" "router" {
  name                = "${var.name}-router"
  admin_state_up      = true
  external_network_id = data.openstack_networking_network_v2.ntnu-internal.id
}

resource "openstack_networking_router_interface_v2" "router_interface" {
  for_each  = var.subnet_cidr
  router_id = openstack_networking_router_v2.router.id
  subnet_id = openstack_networking_subnet_v2.subnet[each.key].id
}
