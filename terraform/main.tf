resource "docker_image" "app_image" {
  name         = "major_project:latest"
  keep_locally = true
}

resource "docker_container" "app_instance1" {
  name  = "app_instance1"
  image = docker_image.app_image.image_id

  ports {
    internal = 8000
    external = 8001
  }

  lifecycle {
    replace_triggered_by = [docker_image.app_image]
  }
}

resource "docker_container" "app_instance2" {
  name  = "app_instance2"
  image = docker_image.app_image.image_id

  ports {
    internal = 8000
    external = 8002
  }

  lifecycle {
    replace_triggered_by = [docker_image.app_image]
  }
}

resource "docker_container" "app_instance3" {
  name  = "app_instance3"
  image = docker_image.app_image.image_id

  ports {
    internal = 8000
    external = 8003
  }

  lifecycle {
    replace_triggered_by = [docker_image.app_image]
  }
}
