resource "docker_image" "netbox" {
  name = "netboxcommunity/netbox:latest"
}

resource "docker_container" "netbox" {
  image = docker_image.netbox.image_id
  name  = "netbox"
}
