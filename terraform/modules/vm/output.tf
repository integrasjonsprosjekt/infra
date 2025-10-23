output "ip" {
  value = openstack_compute_instance_v2.vm.access_ip_v4
}

output "id" {
  value = openstack_compute_instance_v2.vm.id
}
