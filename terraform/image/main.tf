resource "openstack_images_image_v2" "frontend-image" {
  name             = "frontend-image"
  container_format = "bare"
  disk_format      = "qcow2"
  visibility       = "private"
  tags             = ["nix"]

  local_file_path = "${path.module}/../../result-nonsym/frontend.qcow2"
}

resource "openstack_images_image_v2" "backend-image" {
  name             = "backend-image"
  container_format = "bare"
  disk_format      = "qcow2"
  visibility       = "private"
  tags             = ["nix"]

  local_file_path = "${path.module}/../../result-nonsym/backend.qcow2"
}

output "frontend_image_id" {
  value = openstack_images_image_v2.frontend-image.id
}

output "backend_image_id" {
  value = openstack_images_image_v2.backend-image.id
}