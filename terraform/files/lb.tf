resource "google_compute_forwarding_rule" "default" {
  name       = "reddit-forwarding-rule"
  target     = google_compute_target_pool.default.self_link
  port_range = "9292"
}

resource "google_compute_target_pool" "default" {
  name = "reddit-pool"

  instances = google_compute_instance.app.*.self_link

  health_checks = [
    google_compute_http_health_check.default.name
  ]
}

resource "google_compute_http_health_check" "default" {
  name               = "default"
  request_path       = "/"
  check_interval_sec = 10
  timeout_sec        = 5
}
