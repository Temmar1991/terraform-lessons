provider "google" {
  credentials = "${file("~/key.json")}"
  project = "boreal-diode-242221"
  region = "europe-west3"
  zone = "europe-west3-b"

}

resource "google_compute_instance" "test1" {
  name = "test1"
  machine_type = "n1-standard-1"
  
  zone = "europe-west3-b"
  boot_disk {
    initialize_params  {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }
}
