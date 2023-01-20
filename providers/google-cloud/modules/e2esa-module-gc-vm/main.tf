
# Create a single Compute Engine instance
resource "google_compute_instance" "vm" {
  name         = local.name
  machine_type = var.machine_type
  zone         = var.zone
  tags         = merge({ "resourcename" = "${local.name}-vm" }, var.tags)


  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  # Install Flask
  metadata_startup_script = var.startup_script #"sudo apt-get update; sudo apt-get install -yq build-essential python3-pip rsync; pip install flask"

  network_interface {
    subnetwork = google_compute_subnetwork.default.id

    access_config {
      # Include this section to give the VM an external IP address
    }
  }
}