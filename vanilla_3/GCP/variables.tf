variable "project_id" {
  type = string
  default = "sturdy-mode-390401"
}

variable "region" {
  default = "asia-southeast1"
}

variable "zone" {
  default = "asia-southeast1-a"
}

variable "my_ip" {
  description = "Your public IP for SSH access. FORMAT : 123.123.123.123/32"
  type        = string
  default     = "0.0.0.0/0"
}