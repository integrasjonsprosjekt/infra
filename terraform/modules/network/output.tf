output "subnet_ids" {
  value = { for s in openstack_networking_subnet_v2.subnet : s.name => s.id }

}
