
resource "google_compute_instance" "terraform-development" {
  boot_disk {
    auto_delete = true
    device_name = "terraform-development"

    initialize_params {
      image = "projects/${var.project_id}/global/images/ubuntu-22-04-nested-vm-image"
      size  = 100
      type  = "pd-ssd"
    }

    mode = "READ_WRITE"
  }
  metadata_startup_script  = "${file("./start.sh")}"

  can_ip_forward      = false
  deletion_protection = false
  enable_display      = false

  labels = {
    goog-ec-src = "vm_add-tf"
  }

  machine_type = "n2-custom-18-71680"

  metadata = {
    enable-oslogin = "true"
  }

  name = "terraform-development"

  network_interface {
    access_config {
      network_tier = "PREMIUM"
    }

    subnetwork = "projects/${var.project_id}/regions/us-central1/subnetworks/default"
  }

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
    preemptible         = false
    provisioning_model  = "STANDARD"
  }

  shielded_instance_config {
    enable_integrity_monitoring = true
    enable_secure_boot          = false
    enable_vtpm                 = true
  }

  tags = ["http-server", "https-server"]
  zone = "us-central1-a"
}
