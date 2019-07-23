resource "google_container_node_pool" "node_pool" {
  name     = "${var.cluster}-pool"
  project  = var.project
  location = var.zone
  cluster  = google_container_cluster.cluster.name

  initial_node_count = "1"

  autoscaling {
    min_node_count = "1"
    max_node_count = "10"
  }

  management {
    auto_repair  = "true"
    auto_upgrade = "true"
  }

  node_config {
    labels = {
      env = "guestbook-example"
    }

    tags = [
      google_container_cluster.cluster.name,
      "guestbook"
    ]

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }

  lifecycle {
    ignore_changes = [initial_node_count]
  }

  timeouts {
    create = "30m"
    update = "30m"
    delete = "30m"
  }
}
