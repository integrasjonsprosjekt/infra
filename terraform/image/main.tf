resource "null_resource" "frontend_image_trigger" {
  triggers = {
    frontend_image = filesha256("${path.module}/../../result-nonsym/frontend.qcow2")
  }
}

resource "openstack_images_image_v2" "frontend-image" {
  name             = "frontend-image"
  container_format = "bare"
  disk_format      = "qcow2"
  visibility       = "private"
  tags             = ["nix"]

  local_file_path = "${path.module}/../../result-nonsym/frontend.qcow2"
  depends_on = [ null_resource.frontend_image_trigger ]
}

resource "null_resource" "backend_image_trigger" {
  triggers = {
    backend_image = filesha256("${path.module}/../../result-nonsym/backend.qcow2")
  }
  
}

resource "openstack_images_image_v2" "backend-image" {
  name             = "backend-image"
  container_format = "bare"
  disk_format      = "qcow2"
  visibility       = "private"
  tags             = ["nix"]

  local_file_path = "${path.module}/../../result-nonsym/backend.qcow2"
  depends_on = [ null_resource.backend_image_trigger ]
}

output "frontend_image_id" {
  value = openstack_images_image_v2.frontend-image.id
}

output "backend_image_id" {
  value = openstack_images_image_v2.backend-image.id
}