# locals {
#   listener_ports = { for l in openstack_lb_listener_v2.listener : l.id => l.protocol_port }
# }

# output "pool_ids" {
#   value = { for p in openstack_lb_pool_v2.pool : local.listener_ports[p.listener_id] => p.id }
# }

output "lb_endpoint" {
  value = openstack_networking_floatingip_v2.floating_ip[0].address
}
