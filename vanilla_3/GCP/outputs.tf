output "load_balancer_ip" {
  description = "Public IP of the HTTP Load Balancer"
  value       = module.loadbalancer.lb_ip
}

output "instance_group" {
  description = "Managed Instance Group Name"
  value       = module.vm-template.instance_group
}

output "standalone_vm_public_ip" {
  description = "IP Public of Provisioned Standalone VM"
  value = module.compute.standalone_vm_public_ip
}