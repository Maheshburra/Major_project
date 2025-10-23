terraform {
  required_version = ">= 1.5.0"

  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.2"
    }
  }

  # backend "local" {
  #   path = "terraform.tfstate"
  # }
}

# --------------------------------------------------
# Provider Configuration
# --------------------------------------------------
provider "docker" {
  # On Windows, you can optionally specify the host like this:
  # host = "npipe:////./pipe/docker_engine"
}

# --------------------------------------------------
# Docker Image Resource
# --------------------------------------------------
resource "docker_image" "app_image" {
  name         = "major_project:latest"
  keep_locally = true
}

# --------------------------------------------------
# Docker Containers
# --------------------------------------------------
resource "docker_container" "app_instance1" {
  name  = "app_instance1"
  image = docker_image.app_image.image_id

  ports {
    internal = 8000
    external = 8001
  }

  lifecycle {
    replace_triggered_by   = [docker_image.app_image]
    create_before_destroy  = true  # Prevents missing-image errors
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
    replace_triggered_by   = [docker_image.app_image]
    create_before_destroy  = true
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
    replace_triggered_by   = [docker_image.app_image]
    create_before_destroy  = true
  }
}
