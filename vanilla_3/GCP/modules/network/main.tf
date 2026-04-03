resource "google_compute_network" "vpc" {
  name                    = var.network_name
  auto_create_subnetworks = true
}

resource "google_compute_firewall" "allow_http_ssh" {
  name    = "${var.network_name}-fw"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["80", "22"]
  }

  source_ranges = ["${var.my_ip}"]
}

# Required for Google LB health checks
resource "google_compute_firewall" "allow_health_check" {
  name    = "${var.network_name}-hc"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["130.211.0.0/22", "35.191.0.0/16"]
}