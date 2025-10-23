output "subnet_ids" {
  value = { for s in openstack_networking_subnet_v2.subnet : s.name => s.id }

}

output "network_id" {
  value = openstack_networking_network_v2.network.id
}