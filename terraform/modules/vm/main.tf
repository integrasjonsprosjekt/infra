resource "openstack_compute_instance_v2" "vm" {
  name        = var.name
  image_id    = var.image_id
  flavor_name = var.flavor
  user_data   = var.user_data
  network {
    port = openstack_networking_port_v2.vm_port.id
  }
}

// Attach volumes to VM
resource "openstack_compute_volume_attach_v2" "volume_attach" {
  count       = length(var.volume_ids)
  instance_id = openstack_compute_instance_v2.vm.id
  volume_id   = var.volume_ids[count.index]
}

// --- Networking ---
// Port with fixed IP and security groups
resource "openstack_networking_port_v2" "vm_port" {
  network_id = data.openstack_networking_subnet_v2.subnet.network_id
  fixed_ip {
    subnet_id = data.openstack_networking_subnet_v2.subnet.id
  }
  security_group_ids = var.security_group_ids
}

// Floating IP for VM
resource "openstack_networking_floatingip_v2" "floating_ip" {
  count = var.floating_ip ? 1 : 0
  pool  = data.openstack_networking_network_v2.ntnu_internal.name
}

resource "openstack_networking_floatingip_associate_v2" "floating_ip_associate" {
  count       = var.floating_ip ? 1 : 0
  floating_ip = openstack_networking_floatingip_v2.floating_ip[0].address
  port_id     = openstack_networking_port_v2.vm_port.id
}
