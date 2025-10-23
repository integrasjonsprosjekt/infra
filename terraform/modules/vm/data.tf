
data "openstack_networking_subnet_v2" "subnet" {
  subnet_id = var.subnet_id
}

data "openstack_networking_network_v2" "ntnu_internal" {
  name = "ntnu-internal"
}
