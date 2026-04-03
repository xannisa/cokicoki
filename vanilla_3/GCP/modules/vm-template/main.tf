resource "google_compute_instance_template" "template" {
  name_prefix  = "vm-template"
  machine_type = var.machine_type

  disk {
    source_image = var.image
    auto_delete  = true
    boot         = true
  }

  network_interface {
    network = var.network
    access_config {}
  }

  metadata_startup_script = file(var.startup_script)
}

resource "google_compute_instance_group_manager" "mig" {
  name               = "vm-group"
  base_instance_name = "vm"

  version {
    instance_template = google_compute_instance_template.template.id
  }

  target_size = var.instance_count

  named_port {
    name = "http"
    port = 80
  }
}
