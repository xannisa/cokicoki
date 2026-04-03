provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

module "network" {
  source       = "./modules/network"
  network_name = "opentofu-network"
  my_ip        = var.my_ip
}

module "vm-template" {
  source = "./modules/vm-template"

  machine_type   = "e2-micro"
  image          = "debian-cloud/debian-11"
  network        = module.network.network_name
  startup_script = "startup.sh"
  instance_count = 1
}

module "loadbalancer" {
  source = "./modules/loadbalancer"

  instance_group = module.vm-template.instance_group
}

module "compute" {
    source = "./modules/compute"
    standalone-vm-name = "opentofu-standalone-vm"
    network        = module.network
    startup_script = "startup.sh"

}