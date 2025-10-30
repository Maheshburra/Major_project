terraform {
  required_version = ">= 1.5.0"

  # 👇 Use local backend, NOT remote operations
  backend "local" {
    path = "terraform.tfstate"
  }

  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.2"
    }
  }
}

provider "docker" {
  # For Windows, Docker host works automatically.
}

# --------------------------------------------------
# Docker Image (Use locally built image)
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
}

resource "docker_container" "app_instance2" {
  name  = "app_instance2"
  image = docker_image.app_image.image_id

  ports {
    internal = 8000
    external = 8002
  }
}

resource "docker_container" "app_instance3" {
  name  = "app_instance3"
  image = docker_image.app_image.image_id

  ports {
    internal = 8000
    external = 8003
  }
}
