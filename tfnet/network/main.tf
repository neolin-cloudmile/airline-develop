variable "network_name" {}
variable "auto_create_subnetworks" {}
variable "routing_mode" {}

resource "google_compute_network" "network" {
  name                    = var.network_name
  auto_create_subnetworks = var.auto_create_subnetworks
  routing_mode            = var.routing_mode
}
