# Output container names
output "container1_name" {
  value = docker_container.app_instance1.name
}

output "container2_name" {
  value = docker_container.app_instance2.name
}

output "container3_name" {
  value = docker_container.app_instance3.name
}
