resource "openstack_lb_loadbalancer_v2" "lb" {
  vip_subnet_id      = var.subnet_id
  security_group_ids = var.security_group_ids
  name               = var.name
}

resource "openstack_lb_listener_v2" "listener" {
  count           = length(var.config)
  loadbalancer_id = openstack_lb_loadbalancer_v2.lb.id
  protocol        = var.config[count.index].protocol
  protocol_port   = var.config[count.index].port
  name            = "${var.config[count.index].name}-listener"
}

resource "openstack_lb_pool_v2" "pool" {
  count       = length(openstack_lb_listener_v2.listener)
  listener_id = openstack_lb_listener_v2.listener[count.index].id
  protocol    = openstack_lb_listener_v2.listener[count.index].protocol
  lb_method   = "ROUND_ROBIN"
  name        = "${var.config[count.index].name}-pool"
}

resource "openstack_lb_monitor_v2" "monitor" {
  count       = length(var.config)
  pool_id     = openstack_lb_pool_v2.pool[count.index].id
  delay       = 5
  timeout     = 5
  max_retries = 3
  type        = var.config[count.index].protocol
  url_path    = var.monitor_path
}

locals {
  pool_port_map = [
    for idx, pool in openstack_lb_pool_v2.pool :
    { id = pool.id, ports = { for a in var.config[idx].addresses : a => var.config[idx].port } }
  ]
}

resource "openstack_lb_members_v2" "lb_members" {
  count   = length(local.pool_port_map)
  pool_id = local.pool_port_map[count.index].id

  dynamic "member" {
    for_each = local.pool_port_map[count.index].ports
    content {
      address       = member.key
      protocol_port = member.value
    }
  }
}

// Floating IP for Load Balancer
resource "openstack_networking_floatingip_v2" "floating_ip" {
  count = var.floating_ip ? 1 : 0
  pool  = data.openstack_networking_network_v2.ntnu_internal.name
}

resource "openstack_networking_floatingip_associate_v2" "fip_assoc" {
  count       = var.floating_ip ? 1 : 0
  floating_ip = openstack_networking_floatingip_v2.floating_ip[0].address
  port_id     = openstack_lb_loadbalancer_v2.lb.vip_port_id
}
