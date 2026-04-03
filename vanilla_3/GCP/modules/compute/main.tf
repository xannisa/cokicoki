resource "google_compute_instance" "vm" {
  name         = var.standalone-vm-name
  machine_type = "e2-micro"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = var.network.network_name
    access_config {}
  }

  metadata_startup_script = file(var.startup_script)
}

resource "google_compute_firewall" "allow_traffic" {
  name    = "allow"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}