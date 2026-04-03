output "lb_ip" {
  value = google_compute_global_forwarding_rule.http.ip_address
}