resource "google_container_cluster" "cluster" {
  name       = var.cluster
  project    = var.project
  location   = var.zone

  remove_default_node_pool = true
  initial_node_count = 1

  timeouts {
    create = "30m"
    update = "30m"
    delete = "30m"
  }
}
