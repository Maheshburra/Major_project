terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.0"
    }
  }
}

# Configure the Docker provider
provider "docker" {
  host = "npipe:////.//pipe//docker_engine"
}

# Pull the local Docker image built by Jenkins
resource "docker_image" "major_project_image" {
  name = "major_project:latest"
}

# Deploy multiple container instances using the same image
resource "docker_container" "app_instance1" {
  name    = "app_instance1"
  image   = docker_image.major_project_image.image_id
  restart = "unless-stopped"
}

resource "docker_container" "app_instance2" {
  name    = "app_instance2"
  image   = docker_image.major_project_image.image_id
  restart = "unless-stopped"
}

resource "docker_container" "app_instance3" {
  name    = "app_instance3"
  image   = docker_image.major_project_image.image_id
  restart = "unless-stopped"
}
