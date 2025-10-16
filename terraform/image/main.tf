resource "openstack_images_image_v2" "frontend-image" {
  name             = "nix-image"
  container_format = "bare"
  disk_format      = "qcow2"
  visibility       = "private"
  tags             = ["nix"]

  local_file_path = file("${path.module}/../../result-nonsym/nix-image.qcow2")
}

resource "openstack_images_image_v2" "nix-image" {
  name             = "nix-image"
  container_format = "bare"
  disk_format      = "qcow2"
  visibility       = "private"
  tags             = ["nix"]

  local_file_path = file("${path.module}../../result-nonsym/nix-image.qcow2")

}
