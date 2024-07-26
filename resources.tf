resource "docker_image" "netboxcommunity" {
  name = "netbox:latest"
}

resource "docker_container" "netboxcommunity" {
  image = docker_image.netbox.image_id
  name  = "netbox"
}
