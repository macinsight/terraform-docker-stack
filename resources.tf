resource "docker_image" "netbox" {
  name = "netbox:latest"
}

resource "docker_container" "netbox" {
  image = docker_image.netbox.latest
  name  = "netbox"
}
