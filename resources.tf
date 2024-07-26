resource "docker_image" "netbox" {
  name = "netbox:latest"
}

resource "docker_container" "netbox" {
  image = docker_image.netbox.image_id
  name  = "netbox"
}
