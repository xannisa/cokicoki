resource "google_compute_health_check" "http" {
  name = "http-health-check"

  http_health_check {
    port = 80
  }
}

resource "google_compute_backend_service" "backend" {
  name          = "backend-service"
  protocol      = "HTTP"
  port_name     = "http"
  health_checks = [google_compute_health_check.http.id]

  backend {
    group = var.instance_group
  }
}

resource "google_compute_url_map" "url_map" {
  name            = "url-map"
  default_service = google_compute_backend_service.backend.id
}

resource "google_compute_target_http_proxy" "proxy" {
  name    = "http-proxy"
  url_map = google_compute_url_map.url_map.id
}

resource "google_compute_global_forwarding_rule" "http" {
  name       = "http-rule"
  target     = google_compute_target_http_proxy.proxy.id
  port_range = "80"
}