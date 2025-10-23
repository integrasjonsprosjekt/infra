module "network" {
  source = "../modules/network"
  name   = "main-network"
  subnet_cidr = {
    subnet1 = "10.0.1.0/24"
  }
}

module "secgroup" {
  source = "../modules/secgroup"
  name   = "instance-secgroup"
  direction = "ingress"
  types = [ "http", "https", "ssh" ]
}

module "vm-frontend" {
  source = "../modules/vm"
  name   = "frontend-vm"
  image_id = data.terraform_remote_state.image.outputs.frontend_image_id
  flavor = "gx1.1c1r"
  user_data = null
  security_group_ids = [ module.secgroup.id ]
  floating_ip = true
  volume_ids = []
  subnet_id = module.network.subnet_ids["main-network-subnet-subnet1"]
  depends_on = [ module.network, module.secgroup ]
}

module "vm-backend" {
  source = "../modules/vm"
  name   = "backend-vm"
  image_id = data.terraform_remote_state.image.outputs.backend_image_id
  flavor = "gx1.1c1r"
  user_data = null
  security_group_ids = [ module.secgroup.id ]
  floating_ip = true
  volume_ids = []
  subnet_id = module.network.subnet_ids["main-network-subnet-subnet1"]
  depends_on = [ module.network, module.secgroup ]
}

output "subnet_ids" {
  value = module.network.subnet_ids
}
