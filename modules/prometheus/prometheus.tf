resource "yandex_compute_instance" "monitoring" {
  name                      = "monitoring"
  platform_id               = "standard-v3"
  zone                      = var.zone
  allow_stopping_for_update = true
  folder_id                 = var.folder_id
  hostname                  = "prometheus"

  resources {
    cores         = 2
    memory        = 4
    core_fraction = 20
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
