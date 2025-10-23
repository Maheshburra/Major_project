terraform {
  required_version = ">= 1.5.0"

  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.2"
    }
  }

  # Optional: if you plan to use remote state storage (e.g., S3, Azure, etc.), define the backend here.
  # backend "local" {
  #   path = "terraform.tfstate"
  # }
}

# --------------------------------------------------
# Provider Configuration
# --------------------------------------------------
provider "docker" {
  # You can explicitly specify the Docker host if needed.
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
