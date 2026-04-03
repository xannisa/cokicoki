output "load_balancer_ip" {
  description = "Public IP of the HTTP Load Balancer"
  value       = module.loadbalancer.lb_ip
}

output "instance_group" {
  description = "Managed Instance Group"
  value       = module.compute.instance_group
}

output "network_name" {
  description = "VPC Network Name"
  value       = module.network.network_name
}
