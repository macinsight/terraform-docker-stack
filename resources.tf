resource "docker_image" "netbox" {
  name = "netbox:latest"
}

resource "docker_container" "netbox" {
  image = docker_image.ubuntu.image_id
  name  = "netbox"
}
