module "network" {
  source = "../modules/network"
  name   = "main-network"
  subnet_cidr = {
    subnet1 = "10.0.1.0/24"
  }
}

output "subnet_ids" {
  value = module.network.subnet_ids
}
