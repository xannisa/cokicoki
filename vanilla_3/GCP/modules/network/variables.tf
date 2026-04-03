variable "network_name" {}
variable "my_ip" {
  description = "Your public IP for SSH access FORMAT : 123.123.123.123/32"
  type        = string
  default     = "0.0.0.0/0"
}