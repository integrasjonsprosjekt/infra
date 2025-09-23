resource "openstack_compute_instance_v2" "vm" {
  name        = "vm"
  image_id    = "cf5dc427-0a2d-41ea-a9e8-d3e62e8477d0"
  flavor_name = "gx3.4c2r"
}
