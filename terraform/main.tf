# Specify Docker provider
provider "docker" {
  host = "npipe:////.//pipe//docker_engine"
}

# Docker image resource (pull local image built by Jenkins)
resource "docker_image" "major_project_image" {
  name = "major_project:latest"
}

# Docker containers
resource "docker_container" "app_instance1" {
  name  = "app_instance1"
  image = docker_image.major_project_image.latest
  restart = "unless-stopped"
}

resource "docker_container" "app_instance2" {
  name  = "app_instance2"
  image = docker_image.major_project_image.latest
  restart = "unless-stopped"
}

resource "docker_container" "app_instance3" {
  name  = "app_instance3"
  image = docker_image.major_project_image.latest
  restart = "unless-stopped"
}
