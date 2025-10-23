data "openstack_keymanager_container_v1" "tls_container" {
  name = "lb_tls"
}

locals {
  tls_secret1 = one([
    for c in data.openstack_keymanager_container_v1.tls_container.secret_refs: c.secret_ref
    if c.name == "certificate"
  ])
  lb_fip = "10.212.168.106"
}

resource "openstack_lb_loadbalancer_v2" "loadbalacer" {
  name = "loadbalancer"
  vip_subnet_id = module.network.subnet_ids["main-network-subnet-subnet1"]
}

resource "openstack_networking_floatingip_associate_v2" "fip_assoc" {
  floating_ip = local.lb_fip # Not managed by terraform because it is coded in the tls certificate
  port_id     = openstack_lb_loadbalancer_v2.loadbalacer.vip_port_id
}

resource "openstack_lb_listener_v2" "https-listener" {
  loadbalancer_id = openstack_lb_loadbalancer_v2.loadbalacer.id
  protocol = "TERMINATED_HTTPS"
  protocol_port = 443
  default_tls_container_ref = local.tls_secret1 # Not managed by terraform because it is stored in the state
}

resource "openstack_lb_listener_v2" "http-listener" {
  loadbalancer_id = openstack_lb_loadbalancer_v2.loadbalacer.id
  protocol = "HTTP"
  protocol_port = 80
}

resource "openstack_lb_l7policy_v2" "frontend-l7policy" {
  name = "frontend-l7policy"
  listener_id = openstack_lb_listener_v2.http-listener.id
  action = "REDIRECT_TO_URL"
  redirect_url = "https://${local.lb_fip}/"
}

resource "openstack_lb_l7rule_v2" "match-all" {
  l7policy_id = openstack_lb_l7policy_v2.frontend-l7policy.id
  type = "PATH"
  compare_type = "STARTS_WITH"
  value = "/"
}

resource "openstack_lb_pool_v2" "frontend-pool" {
  name = "frontend-pool"
  listener_id = openstack_lb_listener_v2.https-listener.id
  lb_method = "ROUND_ROBIN"
  protocol = "HTTP"
}

resource "openstack_lb_members_v2" "frontend_members" {
  pool_id = openstack_lb_pool_v2.frontend-pool.id
  member {
    name = "frontend-vm-member"
    address = module.vm-frontend.ip
    protocol_port = 80
  }
}

resource "openstack_lb_pool_v2" "backend-pool" {
  name = "backend-pool"
  loadbalancer_id = openstack_lb_loadbalancer_v2.loadbalacer.id
  lb_method = "ROUND_ROBIN"
  protocol = "HTTP"
}
