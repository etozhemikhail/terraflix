resource "yandex_compute_instance" "cicd" {
  name                      = "cicd"
  platform_id               = "standard-v3"
  zone                      = var.zone
  allow_stopping_for_update = true
  folder_id                 = var.folder_id
  hostname                  = "jenkins"

  resources {
    cores         = 2
    memory        = 8
    core_fraction = 100
  }

  boot_disk {
    initialize_params {
      image_id = var.image_id
    }
  }

  network_interface {
    subnet_id = var.subnet_id
    nat       = true
  }

  scheduling_policy {
    preemptible = true
  }

  metadata = {
    user-data = "${file("./user.txt")}"
  }
}
